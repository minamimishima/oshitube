class Users::SessionsController < Devise::SessionsController
  before_action :reject_deleted_user, only: [:create]

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to bookmarks_path
    flash[:notice] = "ゲストユーザーとしてログインしました"
  end

  def reject_deleted_user
    @user = User.find_by(email: params[:user][:email])
    if @user
      if @user.valid_password?(params[:user][:password]) && (@user.is_deleted == true)
        flash[:notice] = "退会済みです。再度登録をしてご利用ください。"
        redirect_to new_user_registration_path
      end
    else
      flash[:notice] = "ユーザーが見つかりません"
      redirect_to new_user_registration_path
    end
  end

  def after_sign_in_path_for(resource)
    bookmarks_path
  end
end
