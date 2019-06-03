# frozen_string_literal: true

class Admin::AuthorsController < Admin::ApplicationController
  def new
  end

  def create
    @author = Author.create(author_permitted_params)

    redirect_to :show, @author
  end

  def edit
  end

  def update
    @author.update(author_permitted_params)

    redirect_to :show, @author
  end

  def destroy
    if @author.destroy
      redirect_to :index
    else
      redirect_to :show, @author
    end
  end

  def show
  end

  def index
  end

  private

  def author_permitted_params
    params.require(:author).permit(:firstname,
                                   :lastname,
                                   :user)
  end
end
