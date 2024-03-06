class BookmarksController < ApplicationController
  before_action :authenticate_user!
  before_action :get_current_user
  before_action :correct_user, except: [:index, :show]

  def index
    @bookmarks = @user.bookmarks.order(created_at: :desc).page(params[:page])
    @category = Category.new
  end

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.url = @bookmark.extract_video_url(params[:bookmark][:url])
    @bookmark.video_id = @bookmark.extract_video_id(params[:bookmark][:url])
    if @bookmark.save
      flash[:notice] = "登録完了しました"
      redirect_to bookmarks_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def show
    @bookmark = Bookmark.find(params[:id])
    @timestamp = Timestamp.new
    @timestamps = @bookmark.timestamps.sort_by(&:start_time)
    gon.video_id = @bookmark.video_id
    gon.start_time_list = @timestamps.pluck(:start_time)
    if @bookmark.user.id != @user.id && @bookmark.is_public == false
      redirect_to root_path
    end
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
  end

  def update
    @bookmark = Bookmark.find(params[:id])
    new_params = bookmark_params
    new_params[:url] = @bookmark.extract_video_url(params[:bookmark][:url])
    new_params[:video_id] = @bookmark.extract_video_id(params[:bookmark][:url])

    if new_params[:timestamps_attributes].present?
      (0..9).each do |i|
        if new_params[:timestamps_attributes][i.to_s].present?
          new_params[:timestamps_attributes][i.to_s][:start_time] =
            new_params[:timestamps_attributes][i.to_s][:hour].to_i * 3600 +
            new_params[:timestamps_attributes][i.to_s][:minute].to_i * 60 +
            new_params[:timestamps_attributes][i.to_s][:second].to_i
        end
      end
    end

    if @bookmark.update(new_params)
      flash[:notice] = "編集完了しました"
      redirect_to bookmark_path(@bookmark.id)
    else
      flash[:edit_error_message] = "登録内容を確認してください"
      @bookmark = Bookmark.find(params[:id])
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

  def get_current_user
    @user = current_user
  end

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
      timestamps_attributes: [:id, :bookmark_id, :hour, :minute, :second, :start_time, :comment, :_destroy]
    )
  end
end
