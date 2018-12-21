module SessionsHelper
  # 渡されたユーザーでログインする
  def log_in(user)
    session[:user_account] = user.account
  end

  # 現在ログイン中のユーザーを返す (いる場合)
  def current_user
    if session[:user_account]
      @current_user ||= User.find_by(account: session[:user_account])
    end
  end

  # 渡されたユーザーがログイン済みユーザーであればtrueを返す
  def current_user?(user)
    user == current_user
  end
  
  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end

  # 現在のユーザーをログアウトする
  def log_out
    session.delete(:user_account)
    @current_user = nil
  end

  # ログイン済みなユーザーが確認
  def logged_in_user
    unless logged_in?
      flash[:danger] = "ログインしてください"
      redirect_to login_url
    end
  end

  # 正しいユーザーかどうか確認
  def correct_user
    @user = User.find_by(account: params[:account])
    redirect_to(root_url) unless @user == current_user
  end
end
