class Users::UsersController < ApplicationController
  def index
    @users = User.all
  end
end
