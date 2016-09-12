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
#  card_last4             :string
#  card_exp_month         :string
#  card_exp_year          :string
#  card_brand             :string
#  google_plus            :string
#  reviewer               :boolean          default(FALSE)
#  country_code           :string
#  affiliate_countries    :string
#

class User < ActiveRecord::Base

  recommends :reviews, :products
  extend FriendlyId
  friendly_id :uid, use: [:slugged, :finders]
  has_many :reviewgroups
  acts_as_commontator

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
  :omniauth_providers => [:google_oauth2]

  validates :username, :email, presence: true, uniqueness: true




  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.username = auth.info.email.to_s.split('@')[0].to_s
      user.email = auth.info.email
      user.provider = auth.provider
      user.uid = auth.uid
      user.avatar = auth.info.image
      user.token = auth.credentials.token
      user.refresh_token = auth.credentials.refresh_token
      user.password = Devise.friendly_token.first(12)
      user.google_plus = auth.extra.raw_info.profile
      user.save!
    end
  end

  def self.country_name(country_code)
    ISO3166::Country[country_code].name || nil
  end
end
