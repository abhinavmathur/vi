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
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  reviewer_id       :integer
#

class Review < ActiveRecord::Base
  belongs_to :reviewfiable, polymorphic: true
end
