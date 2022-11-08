class Users::UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
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
