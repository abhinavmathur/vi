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

FactoryGirl.define do
  factory :product do
    sequence(:title) { |n| "product#{n}" }
    sequence(:description) { |n| "description Lorem #{n}" }
    category nil
    company "MyString"
    tags "MyString"
    asin "MyString"
  end
end
