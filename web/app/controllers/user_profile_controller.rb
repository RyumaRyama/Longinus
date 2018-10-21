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
  end

  def create
   @user = User.new(user_params)
   @element = Element.new(element_params)

   if @user.valid? and @element.valid?
     @user.save
     @element.save
     @user.elements << Element.find_by(element_params)
     flash[:success] = "Welcome to the hobbycom!"
     redirect_to user_profile_path(id:@user.id)
   elsif @user.valid? and Element.exists?(element_params)   # Elementが既に存在する場合
     @user.save
     @user.elements << Element.find_by(element_params)
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
      params.require(:element).permit(:name)
    end
end
