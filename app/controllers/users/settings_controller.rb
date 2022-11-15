# frozen_string_literal: true

class Users::SettingsController < Devise::ConfirmationsController
  # GET /resource/confirmation/new
  # def new
  #   super
  # end

  # POST /resource/confirmation
  def create
    user_registration = User::Registration.find_or_initialize_by(unconfirmed_email: params[:setting][:email], email: current_user.email)
    if user_registration.save
      super do
        flash[:notice] = "メールアドレスの変更を受け付けました。"
        return render :create
      end
    else
      respond_with(user_registration)
    end
  end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    ActiveRecord::Base.transaction do
      @user = current_user.update!(email: self.resource.email)
      # @user_database_authentication = User::DatabaseAuthentication.new(user: @user, email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
      # @user_database_authentication.save!
      self.resource.destroy!
    end

    flash[:notice] = "メールアドレスの変更が完了いたしました！"
    redirect_to users_user_path(current_user)
  rescue
    render :new
  end

  # protected

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  # The path used after confirmation.
  # def after_confirmation_path_for(resource_name, resource)
  #   super(resource_name, resource)
  # end
end
