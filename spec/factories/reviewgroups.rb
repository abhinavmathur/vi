# == Schema Information
#
# Table name: reviewgroups
#
#  id                :integer          not null, primary key
#  title             :string
#  short_description :string
#  category_id       :integer
#  user_id           :integer
#  slug              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

FactoryGirl.define do
  factory :reviewgroup do
    title "MyString"
    short_description "MyString"
    category_id 1
    user_id 1
  end
end
