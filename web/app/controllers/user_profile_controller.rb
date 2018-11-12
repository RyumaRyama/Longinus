# coding: utf-8
class UserProfileController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :follow_requests, :friends]
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

  def follow_requests
    @title = "Request"
    @user = User.find(params[:id])
    @users = @user.find_follow_requests.paginate(page: params[:page])
    render 'show_follow'
  end

  def friends
    @title = "Friends"
    @user = User.find(params[:id])
    @users = @user.find_friends.paginate(page: params[:page])
    render 'show_follow'
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
