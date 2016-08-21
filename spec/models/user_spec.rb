# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  username               :string           default("")
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  token                  :string
#  refresh_token          :string
#  provider               :string
#  uid                    :string
#  slug                   :string
#  avatar                 :string
#  description            :text
#  has_youtube_account    :boolean          default(FALSE)
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  stripe_id              :string
#  admin                  :boolean          default(FALSE)
#  manager                :boolean          default(FALSE)
#

require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
