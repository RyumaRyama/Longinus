class ElementController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:edit, :update]

  def new
    @element = Element.new
    @users_element = UsersElement.new
  end

  def create
    @user = current_user
    add_elements("Welcome to Hobbycom!")
  end

  def edit
    @user = User.find_by(account: params[:account])
    @element = Element.new
    @users_element = UsersElement.new

    if @user.elements.size == 0
      redirect_to new_element_path
    end
  end

  def update
    @user = User.find_by(account: params[:account])

    # 趣味を削除
    update_user_elements_params[:elements_attributes].each do |element|
      if element[1][:_destroy] == "1"
        @user.elements.delete(Element.find_by(id: element[1][:id]))
      end
    end

    # 趣味の公開設定の変更
    update_user_elements_params[:users_elements_attributes].each do |user_element_is_private|
      if not UsersElement.find_by(id: user_element_is_private[1][:id]).nil?
        user_element = UsersElement.find_by(id: user_element_is_private[1][:id])
        puts "失敗した"*100
        p user_element
        @user.users_elements.find_by(element_id: user_element.element_id
        ).update!(private: user_element_is_private[1][:private])
      end
    end

    add_elements("Update successfull")
  end

  private

    def element_params
      params.require(:element).permit(
        elements: [:name],
        users_elements_attributes: [:private]
      )
      # params.require(:elements).map do |param|
      #   param.permit(:name)
      # end
    end

    def update_user_elements_params
      params.require(:user).permit(
        users_elements_attributes: [:private,:id],
        elements_attributes: [:name, :id, :_destroy]
      )
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
      redirect_to user_profile_path(account: @user.account)
    end
end
