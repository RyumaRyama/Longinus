class ElementController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:edit, :update]

  def new
    @element = Element.new
  end

  def create
    @user = current_user
    add_elements("Welcome to Hobbycom!")
  end

  def edit
    # @user = User.find(current_user.id)
    @user = User.find(params[:id])
    @element = Element.new
    # 2.times { @user.elements.build }
    # @elements = User.find(current_user.id).elements
    # @elements = Element.find(user_elements.ids)
    # p @elements
    # puts '*' * 100
  end

  def update
    @user = User.find(params[:id])
    # @user.elements << Element.find_by(update_user_elements_params)
    # if @user.update_attributes(update_user_elements_params)
    #   redirect_to root_path
    # else
    #   render 'edit'
    # end
    
    update_user_elements_params[:elements_attributes].each do |element|
      if element[1][:_destroy] == "1"
        @user.elements.delete(Element.find_by(id: element[1][:id]))
      end
    end

    add_elements("Update successfull")
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

    def add_elements(message)
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
      flash[:success] = message
      redirect_to user_profile_path(id: @user.id)
    end

end
