class User < ApplicationRecord
  # Include default devise modules. Others available are:
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable,
          :lockable, :timeoutable, :trackable,
         :omniauthable, omniauth_providers: %i(google)

  has_one :sns_credential, dependent: :destroy



  def password_match?
    self.errors[:password] << I18n.t('errors.messages.blank') if password.blank?
    self.errors[:password_confirmation] << I18n.t('errors.messages.blank') if password_confirmation.blank?
    self.errors[:password_confirmation] << I18n.translate("errors.messages.confirmation", attribute: "password") if password != password_confirmation
    password == password_confirmation && !password.blank?
  end

  # new function to set the password without knowing the current
  # password used in our confirmation controller.
  def attempt_set_password(params)
    p = {}
    p[:name] = params[:name]
    p[:password] = params[:password]
    p[:password_confirmation] = params[:password_confirmation]
    update(p)
  end

  # new function to return whether a password has been set
  def has_no_password?
    self.encrypted_password.blank?
  end

  # Devise::Models:unless_confirmed` method doesn't exist in Devise 2.0.0 anymore.
  # Instead you should use `pending_any_confirmation`.
  def only_if_unconfirmed
    pending_any_confirmation {yield}
  end



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

  def password_required?
    if !persisted?
      false
    else
      !password.nil? || !password_confirmation.nil?
    end
  end
end
