class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])

      # ユーザーログイン後にユーザー情報のページにリダイレクトする
      log_in user
      redirect_to user_profile_path(account: user.account)
    else
      flash.now[:danger] = 'メールアドレスまたはパスワードが正しくありません'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
