class TimestampsController < ApplicationController
  def create
    @timestamp = Timestamp.new(timestamp_params)
    @bookmark = @timestamp.bookmark
    @timestamps = @bookmark.timestamps.sort_by(&:start_time)
    @timestamp.start_time = @timestamp.calculate_start_time
    if @timestamp.save
      flash[:notice] = "登録完了しました"
      redirect_to bookmark_path(@timestamp.bookmark_id)
    else
      render 'bookmarks/show', status: :unprocessable_entity
    end
  end

  private

  def timestamp_params
    params.require(:timestamp).permit(:bookmark_id, :hour, :minute, :second, :start_time, :comment)
  end
end
