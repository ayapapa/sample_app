module SessionsHelper

  # 渡されたユーザーでログインする
  def log_in(user)
    # session(Railsで事前定義済み)メソッドは、ハッシュライクに扱える
    # 以下を実行することで、ユーザーのブラウザ内の一時cookiesに
    # 暗号化済みのユーザーIDが自動で作成される
    session[:user_id] = user.id
  end

  # ユーザーのセッションを永続的にする
  def remember(user)
    # userインスタンスのrememberメソッドを呼ぶ
    user.remember
    # 永続的クッキーに署名付きで（暗号化された）user_id格納
    cookies.permanent.signed[:user_id] = user.id
    # さらに、トークンを格納する。
    cookies.permanent[:remember_token] = user.remember_token
  end

  # 現在ログイン中のユーザーを返す (いる場合)
  def current_user
    # セッションが有効ならセッションからカレンとユーザーを確定
    # ちなみに、@変数はインスタンス変数（その場で定義して、以降使える）
    # さらに、self.変数もインスタンス変数だが、アクセサ定義されたもの
    # class Foo
    #   attr_reader :hoge
    # ときたら、self.hogeでアクセスできる。また、@hogeでもアクセス可。
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    # セッションが無い場合かつクッキーが存在すれば、クッキーからユーザーを確定
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      # userが存在し、認証できたら、ヘルパーのlog_inメソッドを呼び、
      # current_userにuserを格納する
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end

  # 現在のユーザーをログアウトする
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # 永続的セッションを破棄する
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

end
