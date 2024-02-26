class TimestampsController < ApplicationController
  def create
    @timestamp = Timestamp.new(timestamp_params)
    @bookmark = Bookmark.find(@timestamp.bookmark_id)
    @timestamp.start_time = @timestamp.hour * 3600 + @timestamp.minute * 60 + @timestamp.second
    if @timestamp.save
      flash[:notice] = "登録完了しました"
      redirect_to bookmark_path(@timestamp.bookmark_id)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def timestamp_params
    params.require(:timestamp).permit(:bookmark_id, :hour, :minute, :second, :start_time, :comment)
  end
end
