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
  acts_as_commontable
  searchkick

  before_save :build_affiliate_link

  has_many :clicks

  validates_presence_of :title, :description, :tags

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

  def build_affiliate_link
    if self.has_youtube_link?
      link = "http://www.amazon.com/dp/#{self.asin}/?tag=#{self.affiliate_tag}"
      self.update(affiliate_link: link)
    end
  end
end
