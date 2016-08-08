# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  title       :string           default("")
#  description :text
#  category_id :integer
#  company     :string
#  tags        :string
#  asin        :string
#  slug        :string
#  adult       :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Product < ActiveRecord::Base
  belongs_to :category
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  has_many :reviews, as: :reviewfiable

  validates :title, :description, :company, :tags, presence: true
  validates :title, :description, uniqueness: true


  def slug_candidates
    [
        :name,
        [:name, :id],
    ]
  end

  def self.from_amazon(asin)
    result = Amazon::Ecs.item_lookup(asin, {response_group: 'Medium, BrowseNodes'})
    unless result.has_error?
      item_attributes = result.get_element('ItemAttributes')
      title = item_attributes.get('Title')
      description = sanitize(result.get_element('Content').to_s)
      company = item_attributes.get('Label')
      tags =  item_attributes.get('ProductGroup')
      category = Product.get_category(result)
      asin = result.get_element('ASIN').to_s.html_safe
      unless Product.exists?(asin: asin)
        product = Product.create(title: title, description: description,
                                 company: company, tags: tags, asin: asin, category_id: category.id)
        return 'notice', product
      end
      return 'error', 'The product you searched for already exists'
    else
      return 'error', result.error
    end
  end

  def self.get_category(res)
    arr=[]
    nodes = res.get_elements('BrowseNode')
    nodes.each do |node|
      arr.push(node.get('Name'))
      arr.push(node.get('IsCategoryRoot')) unless node.get('IsCategoryRoot').blank?
    end

    root_category = arr[arr.index('1').to_i + 1].to_s unless arr.count == 0
    cat = Category.find_or_create_by(name: root_category || 'Other')
    cat
  end


  private

  def get_root_category(arr)
    arr[arr.index('1') + 1].to_s.titleize || 'Other'
  end

  def return_category_id(name)
    output = Category.find_or_create_by(name: name)
    output.id
  end

  def prohibited_category_names
    ['Products','Categories','Electronics Features','Featured Categories']
  end

  def amazon_category_array(res)
    nodes = res.get_elements('BrowseNode')
    unless nodes.nil?
      arr=[]
      nodes.each do |node|
        unless prohibited_category_names.include?(node)
          arr.push(node.get('Name'))
        end
      end
      return arr.uniq.join(', ')
    end
    ['1', 'Not Defined'].join(', ')
  end





end
