# == Schema Information
#
# Table name: places
#
#  id              :integer          not null, primary key
#  name            :string           default(""), not null
#  address         :string           default("")
#  city            :string           default("")
#  lat             :float
#  lon             :float
#  full_address    :string           default("")
#  owner           :integer
#  confirmed       :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  slug            :string
#  category_number :integer
#

FactoryGirl.define do
  factory :place do
    name "MyString"
    address "MyString"
    lat 1.5
    lon 1.5
    full_address "MyString"
    type ""
  end
end
