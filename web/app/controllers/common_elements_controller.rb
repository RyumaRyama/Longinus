class CommonElementsController < ApplicationController
  def show
    friend = User.find_by(account: params[:account])
    @friend_name = friend.name
    @friend_elements = friend.elements.where(id: current_user.elements)
  end
end
