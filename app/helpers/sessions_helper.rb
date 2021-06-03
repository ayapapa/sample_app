module SessionsHelper

  # 渡されたユーザーでログインする
  def log_in(user)
    # session(Railsで事前定義済み)メソッドは、ハッシュライクに扱える
    # 以下を実行することで、ユーザーのブラウザ内の一時cookiesに
    # 暗号化済みのユーザーIDが自動で作成される
    session[:user_id] = user.id
  end

  # 現在ログイン中のユーザーを返す (いる場合)
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end

  # 現在のユーザーをログアウトする
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

end
