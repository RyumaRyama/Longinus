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
      log_in @user
      redirect_to new_element_path
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # 更新に成功した場合を扱う。
      redirect_to user_profile_path(id: @user.id)
    else
      render 'edit'
    end
  end

  def elements_edit
    @elements = User.find(params[:id]).elements
  end

  def elements_update

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
