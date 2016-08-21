# == Schema Information
#
# Table name: points
#
#  id          :integer          not null, primary key
#  reviewer_id :integer
#  points      :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Point < ActiveRecord::Base

end
