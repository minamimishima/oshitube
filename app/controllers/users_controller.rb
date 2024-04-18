class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :get_current_user, except: [:show]
  before_action :prevent_guest_user_data_changes, only: [:profile_update]
  before_action :prevent_guest_user_data_deletion, only: [:withdrawal]

  def show
    @user = User.find(params[:id])
    @bookmarks = @user.bookmarks.where(is_public: true).sort_by(&:created_at).reverse
  end

  def profile_edit
  end

  def profile_update
    if @user.update(profile_params)
      redirect_to user_path(@user)
    else
      render 'profile_edit', status: :unprocessable_entity
    end
  end

  def confirm
  end

  def withdrawal
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会しました"
    redirect_to root_path
  end

  private

  def prevent_guest_user_data_changes
    if current_user.email == "guest@example.com"
      flash[:notice] = "ゲストユーザーは編集できません"
      redirect_to user_path(current_user.id)
    end
  end

  def prevent_guest_user_data_deletion
    if current_user.email == "guest@example.com"
      flash[:notice] = "ゲストユーザーは退会できません"
      redirect_to user_path(current_user.id)
    end
  end

  def profile_params
    params.require(:user).permit(:name, :profile, :icon)
  end
end
