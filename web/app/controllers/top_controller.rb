class TopController < ApplicationController
  def index
    if logged_in?
      redirect_to user_profile_path(current_user)
    end
  end
end
