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

require 'rails_helper'

RSpec.describe Reviewgroup, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
