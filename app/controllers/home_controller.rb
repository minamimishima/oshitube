class HomeController < ApplicationController
  before_action :get_current_user
  def index
  end

  private

  def get_current_user
    @user = current_user
  end
end
