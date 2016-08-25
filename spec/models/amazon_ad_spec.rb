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

require 'rails_helper'

RSpec.describe AmazonAd, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
