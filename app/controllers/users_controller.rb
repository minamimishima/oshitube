class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:profile_edit, :profile_update]

  def show
    @user = User.find(params[:id])
    @bookmarks = @user.bookmarks.where(is_public: true).sort_by(&:created_at).reverse
  end

  def profile_edit
    @user = current_user
  end

  def profile_update
    @user = current_user
    if @user.update(profile_params)
      redirect_to user_path(@user.id)
    else
      render 'profile_edit', status: :unprocessable_entity
    end
  end

  def profile_params
    params.require(:user).permit(:name, :profile, :icon)
  end
end
