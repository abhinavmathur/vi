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
#

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "text#{n}@example.com"}
    password 'password'

    trait :admin do
      admin true
    end

    trait :manager do
      manager true
    end
  end
end
