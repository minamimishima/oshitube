class BookmarksController < ApplicationController
  before_action :authenticate_user!
  before_action :get_current_user

  def index
    @bookmarks = Bookmark.all.order(created_at: :desc).page(params[:page])
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
    start_time_list = @timestamps.pluck(:start_time)
    gon.start_time_list = start_time_list
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
  end

  def update
    @bookmark = Bookmark.find(params[:id])
    new_params = bookmark_params
    url = @bookmark.extract_video_url(params[:bookmark][:url])
    video_id = @bookmark.extract_video_id(params[:bookmark][:url])
    params[:bookmark][:url] = url
    params[:bookmark][:video_id] = video_id

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
