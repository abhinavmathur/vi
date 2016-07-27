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

require 'rails_helper'

RSpec.describe Place, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
