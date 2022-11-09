# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    puts params
    puts 'debug'
    super
  end


  # ==============================
  # POST /resource/confirmation
  # def create
  #   user_registration = User::Registration.find_or_initialize_by(unconfirmed_email: params[:registration][:email])
  #   if user_registration.save
  #     super do
  #       flash[:notice] = "Sending an email confirmation instruction"
  #       return render :create
  #     end
  #   else
  #     respond_with(user_registration)
  #   end
  # end

  # GET /resource/confirmation?confirmation_token=abcdef
  # def show
  #   super do
  #     @user = User.new
  #     @user_database_authentication = User::DatabaseAuthentication.new
  #     return render :show
  #   end
  # end
  # ==============================


  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
