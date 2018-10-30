# coding: utf-8
class UserProfileController < ApplicationController
  def home
  end

  def help
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    @element = Element.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to new_element_path
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(
          :name,
          :email,
          :password,
          :password_confirmation
      )
    end

    def element_params
      params.require(:elements).map do |param|
        param.permit(:name)
      end
    end
end
