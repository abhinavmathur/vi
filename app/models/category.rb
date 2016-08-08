# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :text             default("")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Category < ActiveRecord::Base

  has_many :products

  validates_presence_of :name
  validates_uniqueness_of :name

  def self.select
    Category.order('name').map { |s| [s.name, s.id] }
  end
end
