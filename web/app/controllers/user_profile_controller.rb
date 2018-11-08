# coding: utf-8
class UserProfileController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

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

  # def elements_edit
  #   # @user = User.find(current_user.id)
  #   @user = User.find(params[:id])
  #   # 2.times { @user.elements.build }
  #   # @elements = User.find(current_user.id).elements
  #   # @elements = Element.find(user_elements.ids)
  #   # p @elements
  #   # puts '*' * 100
  # end
  #
  # def elements_update
  #   @user = User.find(params[:id])
  #   # @user.elements << Element.find_by(update_user_elements_params)
  #   if @user.update_attributes(update_user_elements_params)
  #     redirect_to root_path
  #   else
  #     render 'elements_edit'
  #   end
  # end

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
