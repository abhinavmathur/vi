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

class Click < ActiveRecord::Base
  belongs_to :review
end
