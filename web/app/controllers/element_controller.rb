class ElementController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:edit, :update]

  def new
    @element = Element.new
    @users_element = UsersElement.new
  end

  def create
    @user = current_user
    add_elements
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

    # 趣味の公開設定の変更
    update_user_elements_params[:users_elements_attributes].each do |user_element_is_private|
      user_element = UsersElement.find_by(id: user_element_is_private[1][:id])
      @user.users_elements.find_by(element_id: user_element.element_id
      ).update!(private: user_element_is_private[1][:private])
    end

    # 趣味を削除
    update_user_elements_params[:elements_attributes].each do |element|
      if element[1][:_destroy] == "1"
        @user.elements.delete(Element.find_by(id: element[1][:id]))
      end
    end

    add_elements
  end

  private

    def element_params
      params.require(:element).permit(
        elements: [:name],
        users_elements_attributes: [:private]
      )
    end

    def update_user_elements_params
      params.require(:user).permit(
        users_elements_attributes: [:private,:id],
        elements_attributes: [:name, :id, :_destroy]
      )
    end

    def add_elements
      private_list = [] # privateにするelement
      if element_params[:users_elements_attributes] != nil
        element_params[:users_elements_attributes].each do |private|
          private_list << private
        end
      end

      element_params[:elements].size.times do |i|
        add_element = true

        # elementの追加
        ep = element_params[:elements][i]
        @element = Element.new(ep)
        if @element.save
          @user.elements << Element.find_by(ep)
        elsif Element.exists?(name: @element.name)     # Elementが既に存在する場合
          @user.elements << Element.find_by(ep) unless @user.elements.exists?(name: @element.name)
        else
          add_element = false
        end

        # private設定
        if add_element
          users_element = @user.users_elements.find_by(
            element_id: Element.find_by(name: @element.name).id)

          if (not private_list.empty?) and private_list[0][0] == i.to_s     # privateとして設定するか
            private_list.shift
            # user_element = UsersElement.find_by(id: user_element_is_private[1][:id])
            users_element.update!(private: true)
          else
            users_element.update!(private: false)
          end
        end
      end

      redirect_to user_profile_path(account: @user.account)
    end
end
