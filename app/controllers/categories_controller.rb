class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_current_user

  def index
    @categories = @user.categories
  end

  private

  def get_current_user
    @user = current_user
  end
end
