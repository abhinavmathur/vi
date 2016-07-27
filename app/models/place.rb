# == Schema Information
#
# Table name: places
#
#  id           :integer          not null, primary key
#  name         :string           default(""), not null
#  address      :string           default("")
#  city         :string           default("")
#  lat          :float
#  lon          :float
#  full_address :string           default("")
#  type         :string           default("")
#  owner        :integer
#  confirmed    :boolean          default(FALSE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Place < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  CATEGORIES = 7

  validates :name, :address, :category_number, presence: true
  validates :name, :address, uniqueness: true


  def self.categories
    [["Restaurants/Bars/Nightlife", 1],
     ["Outdoor Activities/Adventure Sports", 2],
     ["Handmade Products", 3],
     ["Travel & Leisure/Tours", 4],
     ["Health & Fitness/Memberships/Clubs", 5],
     ["Education/Training", 6],
     ["Services", 7]
    ]
  end

  def self.get_category_from_number(number)
    if number > CATEGORIES
      return
    end
    self.categories.select { |category, num| num == number}.first[0].to_s
  end

end
