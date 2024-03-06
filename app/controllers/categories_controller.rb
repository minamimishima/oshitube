class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_current_user

  def index
    @categories = @user.categories
  end

  def new
    @category = Category.new(category_params)
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to bookmarks_path
    else
      render 'bookmarks/index'
    end
  end

  private

  def get_current_user
    @user = current_user
  end

  def category_params
    params.require(:category).permit(:user_id, :category_name)
  end
end
