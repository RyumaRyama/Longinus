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
  end

  def create
   @user = User.new(user_params)
   @category = Category.new(category_params)
   @element = @category.elements.build(element_params)
   # FIX:慣習的によろしくないかも
   @user_introduction = UserIntroduction.new(user_id: @user.id, category_id: @category.id,
                                             element_id: @element.id)

   if @user.save and @category.save and @element.save and @user_introduction.save
     flash[:success] = "Welcome to the hobbycom!"
     redirect_to @user
   else
     render 'new'
   end

  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def category_params
      params.require(:category).permit(:name)
    end

    def element_params
      params.require(:element).permit(:name)
    end
end
