# frozen_string_literal: true

class Admin::CategoriesController < Admin::ApplicationController
  def new
  end

  def create
    @category = Category.create(category_permitted_params)

    redirect_to :show, @category
  end

  def edit
  end

  def update
    @category.update(category_permitted_params)

    redirect_to :show, @category
  end

  def destroy
    if @category.destroy
      redirect_to :index
    else
      redirect_to :show, @category
    end
  end

  def show
  end

  def index
    @categories = Category.page(params[:page] || 1).per(10)
  end

  private

  def category_permitted_params
    params.require(:category).permit(:title,
                                 :subtitle,
                                 :content,
                                 :posts)
  end
end
