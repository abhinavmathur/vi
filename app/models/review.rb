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



end
