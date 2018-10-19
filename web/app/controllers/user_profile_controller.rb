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
    @category = Category.new
    @element = @category.elements.build()
  end

  def create
   @user = User.new(user_parames)
   @category = Category.new(category_params)
   # FIX:慣習的によろしくないかも
   if @category.valid? and @user.valid?
     @user.save
     @category.save
     @element = @category.elements.build(element_params)
     if @element.valid?
       @element.save
     end
     flash[:success] = "Welcome to the hobbycom!"
     redirect_to user_profile_path(id:@user.id)
   else
     render 'new'
   end

  end

  private

    def user_parames
      params.require(:user).permit(
          :name,
          :email,
          :password,
          :password_confirmation
      )
    end

    def category_params
      params.require(:category).permit(:name)
    end

    def element_params
      params.require(:element).permit(:name)
    end
end
