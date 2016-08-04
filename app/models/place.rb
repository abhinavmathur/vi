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
  NUMBER_OF_CATEGORIES = 7

  geocoded_by :address, latitude: :lat, longitude: :lon
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }

  validates :name, :address, presence: true, uniqueness: true


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

  def self.get_category_from_number(category_number)
    if category_number > NUMBER_OF_CATEGORIES
      return
    end
    self.categories.select { |category, num| num == category_number}.first[0].to_s
  end

end
