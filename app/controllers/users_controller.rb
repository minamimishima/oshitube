class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:profile_edit, :profile_update]

  def show
    @user = current_user
  end

  def profile_edit
    @user = current_user
  end

  def profile_update
    @user = current_user
    if @user.update(profile_params)
      redirect_to users_show_path
    else
      render 'profile_edit', status: :unprocessable_entity
    end
  end

  def profile_params
    params.require(:user).permit(:name, :profile, :icon)
  end
end
