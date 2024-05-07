class TimestampsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_current_user
  before_action :correct_user, only: [:edit, :update, :destroy]

  def create
    @timestamp = Timestamp.new(timestamp_params)
    @bookmark = @timestamp.bookmark
    if @timestamp.valid? && @timestamp.bookmark.user_id == @user.id
      @timestamp.start_time = @timestamp.calculate_start_time
      @timestamp.save
      flash[:notice] = "登録完了しました"
      redirect_to bookmark_path(@timestamp.bookmark)
    else
      render 'bookmarks/show', status: :unprocessable_entity
    end
  end

  def show
    @timestamp = Timestamp.find(params[:id])
    @timestamps = @timestamp.bookmark.timestamps.sort_by(&:start_time)
  end

  def edit
    @timestamp = Timestamp.find(params[:id])
  end

  def update
    @timestamp = Timestamp.find(params[:id])
    @bookmark = @timestamp.bookmark
    new_params = timestamp_params
    new_params[:start_time] =
      new_params[:hour].to_i * 3600 +
      new_params[:minute].to_i * 60 +
      new_params[:second].to_i
    if @timestamp.update(new_params)
      flash[:notice] = "タイムスタンプを編集しました"
      redirect_to bookmark_path(@bookmark)
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @timestamp = Timestamp.find(params[:id])
    @timestamp.destroy
    flash[:notice] = "タイムスタンプを削除しました"
    redirect_to bookmark_path(@timestamp.bookmark), status: :see_other
  end

  private

  def correct_user
    timestamp = Timestamp.find(params[:id])
    unless timestamp.bookmark.user_id == current_user.id
      redirect_to root_path
    end
  end

  def timestamp_params
    params.require(:timestamp).permit(:bookmark_id, :hour, :minute, :second, :start_time, :comment)
  end
end
