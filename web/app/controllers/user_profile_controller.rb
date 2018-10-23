# coding: utf-8
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

  def new
    @user = User.new
    @element = Element.new
    @elements = []
  end

  def create
    @user = User.new(user_params)

    if @user.save
      element_params.each do |ep|
        @element = Element.new(ep)
        if @element.save
          @user.elements << Element.find_by(ep)
        else
          if Element.exists?(name: @element.name)     # Elementが既に存在する場合
            @user.elements << Element.find_by(ep) unless @user.elements.exists?(name: @element.name)
          end
        end
      end
      flash[:success] = "Welcome to the hobbycom!"
      redirect_to user_profile_path(id:@user.id)
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
