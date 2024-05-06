class TimestampsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_current_user

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

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def timestamp_params
    params.require(:timestamp).permit(:bookmark_id, :hour, :minute, :second, :start_time, :comment)
  end
end
