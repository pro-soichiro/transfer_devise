class Users::UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.preload(:sns_credential).order(created_at: :desc)
  end

  def update
    if current_user.update(user_params)
      redirect_to users_user_path(current_user)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
