class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def index
    @bookmarks = Bookmark.all
  end

  def new
    @bookmark = Bookmark.new
    @user = current_user
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @user = current_user
    if @bookmark.save
      flash[:notice] = "登録完了しました"
      redirect_to bookmarks_path
    else
      flash[:notice] = @bookmark.errors.full_messages.join(", ")
      render 'new', status: :unprocessable_entity
    end
  end

  def show
    @bookmark = Bookmark.find(params[:id])
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
    @user = current_user
  end

  def update
    @bookmark = Bookmark.find(params[:id])
    @user = current_user
    if @bookmark.update(bookmark_params)
      flash[:notice] = "編集完了しました"
      redirect_to bookmark_path(@bookmark.id)
    else
      flash[:notice] = @bookmark.errors.full_messages.join(", ")
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    flash[:notice] = "ブックマークを削除しました"
    redirect_to bookmarks_path, status: :see_other
  end

  private
    
  def bookmark_params
    params.require(:bookmark).permit(:user_id, :url, :description, :is_public)
  end

end
