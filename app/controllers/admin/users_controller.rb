# frozen_string_literal: true

class Admin::UsersController < Admin::ApplicationController
  def new
  end

  def create
    @user = User.create(user_permitted_params)

    redirect_to :show, @user
  end

  def edit
  end

  def update
    @user.update(user_permitted_params)

    redirect_to :show, @user
  end

  def destroy
    if @user.destroy
      redirect_to :index
    else
      redirect_to :show, @user
    end
  end

  def show
  end

  def index
  end

  private

  def user_permitted_params
    params.require(:user).permit(:email,
                                 :password)
  end
end
