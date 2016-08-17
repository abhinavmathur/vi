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

class User < ActiveRecord::Base

  extend FriendlyId
  friendly_id :uid, use: [:slugged, :finders]
  acts_as_commontator
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
  :omniauth_providers => [:google_oauth2]



  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.username = auth.info.email.to_s.split('@')[0].to_s
      user.email = auth.info.email
      user.provider = auth.provider
      user.uid = auth.uid
      user.token = auth.credentials.token
      user.refresh_token = auth.credentials.refresh_token
      user.password = Devise.friendly_token.first(12)
      user.save!
    end
  end
end
