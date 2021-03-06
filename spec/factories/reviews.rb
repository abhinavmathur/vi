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
#  publish           :boolean          default(FALSE)
#  slug              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  reviewer_id       :integer
#  reviewgroup_id    :integer
#  visit_id          :integer
#  target_countries  :string
#

FactoryGirl.define do
  factory :review do
    sequence(:title) { |n| "review#{n}" }
    description "Lorem Ipsum"
    tags "Camera,Electronics"
    youtube_url "youtube_url"
  end
end
