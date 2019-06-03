# frozen_string_literal: true

class Admin::CategoriesController < Admin::ApplicationController
  before_action :load_category, only: %i[edit update destroy show]

  def new
    @category = Category.new
  end

  def create
    @category = Category.create!(category_permitted_params)

    redirect_to admin_categories_path
  end

  def edit; end

  def update
    @category.update(category_permitted_params)

    redirect_to admin_categories_path
  end

  def destroy
    if @category.destroy
      redirect_to admin_categories_path
    else
      redirect_to admin_category_path @category
    end
  end

  def show; end

  def index
    @categories = Category.page(params[:page] || 1).per(10)
  end

  private

  def load_category
    @category = Category.find(params[:id])
  end

  def category_permitted_params
    params.require(:category).permit(:name,
                                     :description,
                                     :active)
  end
end
