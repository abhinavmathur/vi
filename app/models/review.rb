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

class Review < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :finders]
  belongs_to :reviewfiable, polymorphic: true

  validates_presence_of :title, :description

  def slug_candidates
    [
        :title,
        [:title, :id],
    ]
  end

  def self.youtube_video_belongs_to_user?(user, video_id)
    begin
      owner = Yt::ContentOwner.new refresh_token: user.refresh_token, token: user.token
      video = Yt::Video.new id: video_id, auth: owner
      video.file_size
      return true
    rescue
      return false
    end
  end
end
