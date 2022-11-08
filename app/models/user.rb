class User < ApplicationRecord
  # Include default devise modules. Others available are:
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable,
         :omniauthable, omniauth_providers: %i(google)

  has_one :sns_credential, dependent: :destroy

  protected

  def self.find_for_google(auth)
    user = User.find_by(email: auth.info.email)

    unless user
      ActiveRecord::Base.transaction do
        user = User.create!(email: auth.info.email,
                            name:    auth.info.name,
                            password: Devise.friendly_token[0, 20])
        SnsCredential.create!(user_id: user.id,
                              provider: auth.provider,
                              uid:      auth.uid,
                              token:    auth.credentials.token,
                              meta:     auth.to_yaml)
      end
    end
    user
  end
end
