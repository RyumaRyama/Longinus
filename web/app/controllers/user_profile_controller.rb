# coding: utf-8

module Levenshtein
  def self.similarity(str1, str2)
    1 - normalized_distance(str1, str2)
  end
end

class UserProfileController < ApplicationController
  include Levenshtein
  include UserProfileHelper

  before_action :logged_in_user, only: [:edit, :update, :follow_requests, :friends]
  before_action :correct_user, only: [:edit, :update, :follow_requests, :friends]

  def home
  end

  def help
  end

  def show
    @user = User.find_by(account: params[:account])

    # common_elementsの抽出
    if logged_in? and (@user != current_user)
      @friend_name = @user.name
      # elementの抽出（完全一致）
      @common_elements = @user.elements.where(id: current_user.elements)

      # elementの抽出（もしかして一致）
      @maybe_common_elements = []
      current_user.elements.each do |my_element|
        my_element_name = my_element.name.gsub(/(\s|　)+/, '').downcase
        @user.elements.each do |friend_element|
          friend_element_name = friend_element.name.gsub(/(\s|　)+/, '').downcase

          # 完全一致と非公開を除く，共通かもしれない項目を抽出
          if my_element.id != friend_element.id and not is_private_element?(friend_element.id)
            if Levenshtein.similarity(my_element_name, friend_element_name) >= 0.3
              @maybe_common_elements << friend_element
            end
          end
        end
      end
    end
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
    @user = User.find_by(account: params[:account])
  end

  def update
    @user = User.find_by(account: params[:account])
    if @user.update_attributes(user_update_params)
      # 更新に成功した場合を扱う。
      redirect_to user_profile_path(account: @user.account)
    else
      render 'edit'
    end
  end

  def follow_requests
    @title = "友達申請"
    @user = User.find_by(account: params[:account])
    @paginate_array = @user.find_friend_requests
    @paginates = Kaminari.paginate_array(@paginate_array).page(params[:page]).per(20)
    render 'show_follow'
  end

  def friends
    @title = "友達"
    @user = User.find_by(account: params[:account])
    @paginate_array = @user.find_friends
    @paginates = Kaminari.paginate_array(@paginate_array).page(params[:page]).per(20)
    render 'show_follow'
  end

  private
    def user_params
      params.require(:user).permit(
          :account,
          :name,
          :email,
          :password,
          :password_confirmation,
          :biography
      )
    end

    def user_update_params
      params.require(:user).permit(
          :name,
          :email,
          :password,
          :password_confirmation,
          :biography
      )
    end

    def element_params
      params.require(:elements).map do |param|
        param.permit(:name)
      end
    end

end
