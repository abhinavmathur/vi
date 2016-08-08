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
#  adult       :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :product do
    title "MyString"
    description "MyText"
    category nil
    company "MyString"
    tags "MyString"
    asin "MyString"
  end
end
