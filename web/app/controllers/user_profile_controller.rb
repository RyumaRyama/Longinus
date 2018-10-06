class UserProfileController < ApplicationController
  def home
  end

  def help
  end

  def kame
  end

  def ryama
  end

  def gussy
  end

  def show
    @user = User.find(params[:id])
  end
end
