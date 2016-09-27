# == Schema Information
#
# Table name: products
#
#  id               :integer          not null, primary key
#  title            :string           default("")
#  description      :text
#  category_id      :integer
#  company          :string
#  tags             :string
#  asin             :string
#  slug             :string
#  adult            :boolean          default(FALSE)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  product_images   :text
#  sub_category     :string
#  user_id          :integer
#  similar_products :text
#

class Product < ActiveRecord::Base
  serialize :similar_products
  belongs_to :category
  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :finders]


  searchkick match: :word_start, searchable: ['title']

  def search_data
    {
        title: title,
        description: description,
        tags: tags
    }
  end

  has_many :reviews, as: :reviewfiable

  validates :title, :description, :company, :tags, presence: true
  validates :title, :description, uniqueness: true


  def slug_candidates
    [
        :title,
        [:title, :id],
    ]
  end

  def self.from_amazon(asin)
    result = Amazon::Ecs.item_lookup(asin, {response_group: 'Medium, BrowseNodes'})
    unless result.has_error?
      item_attributes = result.get_element('ItemAttributes')
      title = item_attributes.get('Title').to_s.gsub('&amp;', 'and')
      description =  ActionController::Base.helpers.strip_tags(CGI.unescapeHTML((result.get_element('Content').to_s)))
      company = item_attributes.get('Label')
      tags =  "#{Product.get_category_info(result)[0]}, #{Product.get_category_info(result)[1].name}"
      category = Product.get_category_info(result)[1]
      sub_category = Product.get_category_info(result)[0]
      product_images = ActionController::Base.helpers.strip_tags(result.get_elements('LargeImage/URL').join(', '))
      asin = ActionController::Base.helpers.strip_tags(result.get_element('ASIN').to_s)
       unless Product.exists?(asin: asin)
        product = Product.create(title: title, description: description,
                                 company: company, tags: tags, asin: asin,
                                 product_images: product_images,
                                 category_id: category.id, sub_category: sub_category)
        SimilarProducts.new(asin).create!
        return 'notice', product
      end
      return 'error', 'The product you searched for already exists'
    else
      return 'error', result.error
    end
  end

  #returns the sub category string, main category object
  def self.get_category_info(res)
    arr=[]
    #get all nodes(sub categories) from BrowseNode
    nodes = res.get_elements('BrowseNode')
    item_attributes = res.get_element('ItemAttributes')

    nodes.each do |node|
      arr.push(node.get('Name').to_s.gsub('&amp;', 'and'))
      arr.push(node.get('IsCategoryRoot')) unless node.get('IsCategoryRoot').blank?
    end

    main_category = arr[arr.index('1').to_i + 1]

    sub_category = item_attributes.get('ProductGroup')
    main_category = Category.find_or_create_by(name: main_category || 'Other')
    [sub_category, main_category]
  end

  def self.permitted_mimes
    %w(.jpg .png .jpeg)
  end
end
