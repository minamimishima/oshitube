class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_current_user
  before_action :correct_user, only: [:show, :update, :destroy]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @bookmarks = @user.bookmarks.order(created_at: :desc).page(params[:page]) # リクエストスペックに失敗してしまうため追記
    if @category.valid? && @category.user_id == @user.id
      @category.save
      flash[:notice] = "カテゴリーを作成しました"
      redirect_to bookmarks_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def show
    @category = Category.find(params[:id])
    @categories = @user.categories
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:notice] = "カテゴリー名を編集しました"
      redirect_to category_path(@category)
    else
      @category = Category.find(params[:id])
      # カテゴリー名がバリデーションエラーになった場合（blankの場合）、renderされたshowページで
      # カテゴリー名が表示されないため編集前のデータを設定
      @categories = @user.categories
      # renderされたshowページでカテゴリー一覧が表示できるようインスタンス変数を設定
      flash[:edit_error_message] = "カテゴリー名を入力してください"
      # @categoryを設定したことでエラーメッセージが表示されなくなるためフラッシュメッセージでエラーを通知
      render 'categories/show', status: :unprocessable_entity
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:notice] = "カテゴリーを削除しました"
    redirect_to bookmarks_path, status: :see_other
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
