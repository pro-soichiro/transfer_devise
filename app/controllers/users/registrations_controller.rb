# frozen_string_literal: true

class Users::RegistrationsController < Devise::ConfirmationsController

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    user_registration = User::Registration.find_or_initialize_by(unconfirmed_email: params[:registration][:email])
    if user_registration.save
      super do
        flash[:notice] = "仮登録が完了いたしました。"
        return render :create
      end
    else
      respond_with(user_registration)
    end
  end

  def show
    flash[:notice] = nil
    with_unconfirmed_confirmable do
      do_show
    end
    unless @confirmable.errors.empty?
      self.resource = @confirmable
      render 'users/registrations/new'
    end
  end

  def destroy
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    ActiveRecord::Base.transaction do
      @user = User.new(name: params[:name], email: self.resource.email, password: params[:password], password_confirmation: params[:password_confirmation])
      # @user_database_authentication = User::DatabaseAuthentication.new(user: @user, email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
      @user.save!
      # @user_database_authentication.save!
      self.resource.destroy!
    end

    sign_in(:user, @user)
    # sign_in(:database_authentication, @user_database_authentication)

    flash[:notice] = "本登録が完了いたしました！"
    redirect_to user_root_path
  rescue
    render :show
  end

  protected

  def with_unconfirmed_confirmable
    @confirmable = resource_class.find_or_initialize_with_error_by(:confirmation_token, params[:confirmation_token])
    if !@confirmable.new_record?
      @confirmable.only_if_unconfirmed {yield}
    end
  end

  def do_show
    @confirmation_token = params[:confirmation_token]
    self.resource = @confirmable
    render 'users/registrations/show'
  end

end
