# == Schema Information
#
# Table name: amazon_ads
#
#  id         :integer          not null, primary key
#  review_id  :integer
#  title      :string
#  link_id    :string
#  asins      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class AmazonAd < ActiveRecord::Base
  belongs_to :review

  validates :asins, presence: true
end
