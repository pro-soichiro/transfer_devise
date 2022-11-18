# frozen_string_literal: true

class Users::SettingsController < ApplicationController


  def new
  end

  def create
    User::Registration.create!(email: current_user.email,
                   unconfirmed_email: params[:email])
    render :create
  end

  # tokenをフォームに埋め込みパスワードを入力させる
  def show
    @confirmation_token = params[:confirmation_token]
  end

  def destroy
    ActiveRecord::Base.transaction do
      user_registration = User::Registration.confirm_by_token(params[:confirmation_token])
      current_user.update_with_password({
        current_password: params[:current_password],
        email: user_registration.email
      })

      user_registration.destroy!

      flash[:notice] = "メールアドレスの変更が完了いたしました！"
      redirect_to users_user_path(current_user)
    end
  end

end
