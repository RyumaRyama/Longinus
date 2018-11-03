class ElementController < ApplicationController

  def new
    @element = Element.new
  end

  def create
    #FIX:
    @user = current_user

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
    redirect_to user_profile_path(id: @user.id)
  end

  def edit
    # @user = User.find(current_user.id)
    @user = User.find(params[:id])
    # 2.times { @user.elements.build }
    # @elements = User.find(current_user.id).elements
    # @elements = Element.find(user_elements.ids)
    # p @elements
    # puts '*' * 100
  end

  def update
    @user = User.find(params[:id])
    # @user.elements << Element.find_by(update_user_elements_params)
    if @user.update_attributes(update_user_elements_params)
      redirect_to root_path
    else
      render 'edit'
    end
  end

  private

    def element_params
      params.require(:elements).map do |param|
        param.permit(:name)
      end
    end

    def update_user_elements_params
      params.require(:user).permit(elements_attributes: [:name,:id,:_destroy])
    end
end
