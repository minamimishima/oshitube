class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_current_user
  before_action :correct_user, only: [:show, :update, :destroy]

  def new
    @category = Category.new(category_params)
  end

  def create
    @category = Category.new(category_params)
    @bookmarks = @category.bookmarks.order(created_at: :desc).page(params[:page])
    if @category.save
      flash[:notice] = "カテゴリーを作成しました"
      redirect_to bookmarks_path
    else
      render 'bookmarks/index'
    end
  end

  def show
    @category = Category.find(params[:id])
    @categories = @user.categories
    @bookmarks = @category.bookmarks.order(created_at: :desc).page(params[:page])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to category_path(params[:id])
    else
      render 'categories/index'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:notice] = "カテゴリーを削除しました"
    redirect_to bookmarks_path, status: :see_other
  end

  private

  def get_current_user
    @user = current_user
  end

  def correct_user
    category = Category.find(params[:id])
    unless category.user_id == current_user.id
      redirect_to root_path
    end
  end

  def category_params
    params.require(:category).permit(:user_id, :name)
  end
end
