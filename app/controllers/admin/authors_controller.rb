# frozen_string_literal: true

class Admin::AuthorsController < Admin::ApplicationController
  before_action :load_author, only: %i[edit update destroy show]

  def new
    @author = Author.new
  end

  def create
    @author = Author.create!(author_permitted_params)

    redirect_to admin_authors_path
  end

  def edit; end

  def update
    @author.update(author_permitted_params)

    redirect_to admin_authors_path
  end

  def destroy
    if @author.destroy
      redirect_to admin_authors_path
    else
      redirect_to admin_author_path @author
    end
  end

  def show; end

  def index
    @authors = Author.page(params[:page] || 1).per(10)
  end

  private

  def load_author
    @author = Author.find(params[:id])
  end

  def author_permitted_params
    params.require(:author).permit(:firstname,
                                   :lastname,
                                   :user_id,
                                   :active)
  end
end
