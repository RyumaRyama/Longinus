class TopController < ApplicationController
  def index
    if logged_in?
      redirect_to user_profile_path(account: current_user.account)
    end
  end
end
