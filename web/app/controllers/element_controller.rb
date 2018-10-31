class ElementController < ApplicationController

  def new
    @element = Element.new
  end

  def create
    #FIX:
    @user = User.last

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

  def update

  end

  private

    def element_params
      params.require(:elements).map do |param|
        param.permit(:name)
      end
    end
end
