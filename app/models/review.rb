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

class Review < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]
  belongs_to :reviewfiable, polymorphic: true
  acts_as_commontable
  visitable

  has_many :clicks
  has_one :amazon_ad

  validates :title, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 12}
  validates :tags, presence: true, if: :published?
  validates :youtube_url, presence: true, uniqueness: true, if: :published?


  searchkick

  def search_data
    {
        title: title,
        description: description,
        tags: tags,
    }
  end
  

  def should_generate_new_friendly_id?
    title_changed?
  end


  def slug_candidates
    [
        :title,
        [:title, :id],
    ]
  end

  def published?
    publish?
  end

  def has_amazon_product?
    affiliate_tag.present?
  end

  def self.youtube_video_belongs_to_user?(user, video_id)
    begin
      owner = Yt::ContentOwner.new refresh_token: user.refresh_token, token: user.token
      video = Yt::Video.new id: video_id, auth: owner
      video.file_size
      unless video.public? || video.embeddable?
        return false
      end
      return true
    rescue
      return false
    end
  end


end
