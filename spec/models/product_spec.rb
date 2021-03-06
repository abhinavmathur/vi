# == Schema Information
#
# Table name: products
#
#  id               :integer          not null, primary key
#  title            :string           default("")
#  description      :text
#  category_id      :integer
#  company          :string
#  tags             :string
#  asin             :string
#  slug             :string
#  adult            :boolean          default(FALSE)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  product_images   :text
#  sub_category     :string
#  user_id          :integer
#  similar_products :text
#

require 'rails_helper'

RSpec.describe Product, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
