# frozen_string_literal: true

class Admin::UsersController < Admin::ApplicationController
  before_action :load_user, only: %i[edit update destroy show]

  def new
    @user = User.new
  end

  def create
    @user = User.create!(user_permitted_params)

    redirect_to admin_users_path
  end

  def edit; end

  def update
    @user.update(user_permitted_params)

    redirect_to admin_users_path
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path
    else
      redirect_to admin_user_path @user
    end
  end

  def show; end

  def index
    @users = User.page(params[:page] || 1).per(10)
  end

  private

  def load_user
    @user = User.find(params[:id])
  end

  def user_permitted_params
    params.require(:user).permit(:email,
                                 :password)
  end
end
