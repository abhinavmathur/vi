# == Schema Information
#
# Table name: reviews
#
#  id                :integer          not null, primary key
#  title             :string
#  description       :text
#  tags              :string
#  youtube_url       :string
#  affiliate_tag     :string
#  affiliate_link    :string
#  reviewfiable_id   :integer
#  reviewfiable_type :string
#  publish           :boolean
#  slug              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  reviewer_id       :integer
#  reviewgroup_id    :integer
#

FactoryGirl.define do
  factory :review do
    title "MyString"
    description "MyText"
    product nil
    tags "MyString"
    youtube_url "MyString"
  end
end
