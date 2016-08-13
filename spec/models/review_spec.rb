# == Schema Information
#
# Table name: reviews
#
#  id                :integer          not null, primary key
#  title             :string
#  description       :text
#  tags              :string
#  youtube_url       :string
#  other_video_url   :string
#  affiliate_tag     :string
#  affiliate_link    :string
#  has_youtube_link  :boolean          default(FALSE)
#  reviewfiable_id   :integer
#  reviewfiable_type :string
#  publish           :boolean
#  slug              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  reviewer_id       :integer
#

require 'rails_helper'

RSpec.describe Review, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
