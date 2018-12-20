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

  def help
  end

  def show
    @user = User.find_by(account: params[:account])

    # common_elementsの抽出
    if logged_in? and (@user != current_user)
      @friend_name = @user.name

      # elementの抽出
      @maybe_common_elements = []
      @common_elements = []
      current_user.elements.each do |my_element|
        my_element_name = remove_white_spaces(my_element).downcase
        @user.elements.each do |friend_element|
          friend_element_name = remove_white_spaces(friend_element).downcase

          if my_element_name == friend_element_name
            # スペースと大小情報を潰して完全一致する項目を抽出
            @common_elements << friend_element
            # 共通かもにすでに入っている場合は共通かもから削除する
            @maybe_common_elements.delete(friend_element)
          elsif not @user.is_private_element?(friend_element.id)
            # 完全一致に存在しないかを確認
            if not @common_elements.include?(friend_element)
              # 完全一致と非公開を除く，共通かもしれない項目を抽出
              if maybe_common_element?(my_element_name, friend_element_name)
                @maybe_common_elements << friend_element
              end
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

    def maybe_common_element?(my_element, friend_element)
      if my_element.size < friend_element.size
        proportion = my_element.size.to_f / friend_element.size.to_f
      else
        proportion = friend_element.size.to_f / my_element.size.to_f
      end

      if proportion < 0.25
        Levenshtein.similarity(my_element, friend_element) >= 0.2
      elsif proportion > 0.8
        Levenshtein.similarity(my_element, friend_element) >= 0.45
      else
        Levenshtein.similarity(my_element, friend_element) >= 0.3
      end
    end
end
