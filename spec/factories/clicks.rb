# == Schema Information
#
# Table name: clicks
#
#  id         :integer          not null, primary key
#  review_id  :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :click do
    review_id 1
    user_id 1
  end
end
