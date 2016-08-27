# == Schema Information
#
# Table name: reviewgroups
#
#  id                :integer          not null, primary key
#  title             :string
#  short_description :string
#  category_id       :integer
#  user_id           :integer
#  slug              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Reviewgroup < ActiveRecord::Base
  extend FriendlyId

  belongs_to :user
  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    [
        :title,
        [:title, :id],
    ]
  end

  def self.select(user)
    Reviewgroup.where(user_id: user.id).all.order('title DESC').map { |s| [s.title, s.id]}
  end
end
