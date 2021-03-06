# == Schema Information
#
# Table name: reviews
#
#  id                :integer          not null, primary key
#  title             :string
#  description       :text
#  tags              :string
#  youtube_url       :string
#  affiliate_tag     :string
#  affiliate_link    :string
#  reviewfiable_id   :integer
#  reviewfiable_type :string
#  publish           :boolean          default(FALSE)
#  slug              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  reviewer_id       :integer
#  reviewgroup_id    :integer
#  visit_id          :integer
#  target_countries  :string
#

require 'rails_helper'

RSpec.describe Review, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
