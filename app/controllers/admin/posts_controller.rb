# frozen_string_literal: true

class Admin::PostsController < Admin::ApplicationController
  before_action :load_post, only: %i[edit update destroy show]

  def new
    @post = Post.new
  end

  def create
    @post = Post.create!(post_permitted_params)

    redirect_to admin_posts_path
  end

  def edit; end

  def update
    @post.update(post_permitted_params)

    redirect_to admin_posts_path
  end

  def destroy
    if @post.destroy
      redirect_to admin_posts_path
    else
      redirect_to admin_post_path @post
    end
  end

  def show; end

  def index
    @posts = Post.page(params[:page] || 1).per(10)
  end

  private

  def load_post
    @post = Post.find(params[:id])
  end

  def post_permitted_params
    params.require(:post).permit(:title,
                                 :subtitle,
                                 :content,
                                 :author_id,
                                 :active,
                                 category_ids: [])
  end
end
