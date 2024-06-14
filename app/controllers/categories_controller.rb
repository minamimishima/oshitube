class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_current_user
  before_action :correct_user, only: [:show, :update, :destroy]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @categories = @user.categories
    @bookmarks = @user.bookmarks.latest.page(params[:page]) # リクエストスペックに失敗してしまうため追記
    if @category.valid? && @category.user_id == @user.id
      @category.save
      flash.now.notice = "カテゴリーを作成しました"
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def show
    @category = Category.find(params[:id])
    @categories = @user.categories
    @q = @category.bookmarks.ransack(params[:q])
    @bookmarks = @q.result(distinct: true).latest.page(params[:page])
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    @categories = @user.categories
    if @category.update(category_params)
      flash.now.notice = "カテゴリー名を編集しました"
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:notice] = "カテゴリーを削除しました"
    redirect_to bookmarks_path, status: :see_other
  end

  def new_cancel
    @category = Category.new
  end

  def edit_cancel
    @category = Category.find(params[:id])
  end

  private

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
