class BookmarksController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :get_current_user
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    if params[:latest]
      @bookmarks = @user.bookmarks.latest.page(params[:page])
    elsif params[:oldest]
      @bookmarks = @user.bookmarks.oldest.page(params[:page])
    else
      @bookmarks = @user.bookmarks.latest.page(params[:page])
    end
    @category = Category.new
  end

  def new
    @bookmark = Bookmark.new
    @bookmark.categories.new
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.url = @bookmark.extract_video_url(params[:bookmark][:url])
    @bookmark.video_id = @bookmark.extract_video_id(params[:bookmark][:url])
    if @bookmark.valid? && @bookmark.user_id == @user.id
      @bookmark.save
      flash[:notice] = "登録完了しました"
      redirect_to bookmarks_path
    else
      @bookmark.categories.new
      render 'new', status: :unprocessable_entity
    end
  end

  def show
    @bookmark = Bookmark.find(params[:id])
    if user_signed_in?
      if @bookmark.user.id != @user.id && @bookmark.is_public == false
        redirect_to root_path
      else
        @timestamp = Timestamp.new
        gon.video_id = @bookmark.video_id
        gon.start_time_list = @bookmark.timestamps.sort_by(&:start_time).pluck(:start_time)
        gon.max_index = @bookmark.timestamps.size - 1
      end
    else
      if @bookmark.is_public == true
        @timestamp = Timestamp.new
        gon.video_id = @bookmark.video_id
        gon.start_time_list = @bookmark.timestamps.sort_by(&:start_time).pluck(:start_time)
        gon.max_index = @bookmark.timestamps.size - 1
      else
        redirect_to root_path
      end
    end
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
  end

  def update
    @bookmark = Bookmark.find(params[:id])
    new_params = @bookmark.set_new_params(bookmark_params)
    if @bookmark.update(new_params)
      flash[:notice] = "編集完了しました"
      redirect_to bookmark_path(@bookmark.id)
    else
      @bookmark.video_id = Bookmark.find(params[:id]).video_id
      # URLが不正な値の場合、extract_video_methodの返り値がnilになり動画フレームが表示されない
      # 編集前の動画フレームを表示するためvideo_idの値を設定
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

  def correct_user
    bookmark = Bookmark.find(params[:id])
    unless bookmark.user_id == current_user.id
      redirect_to root_path
    end
  end

  def bookmark_params
    params.require(:bookmark).permit(
      :user_id,
      :url,
      :description,
      :is_public,
      :video_id,
      categories_attributes: [:id, :user_id, :name],
      category_ids: [],
    )
  end
end
