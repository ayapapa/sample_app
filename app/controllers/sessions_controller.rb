# セッションコントローラ
# 'rails generate controller Sessions new' で生成
class SessionsController < ApplicationController

  # 新規セッション作成(log-in UI)
  def new
  end

  # 新規セッション作成
  def create
    # 登録済ユーザか否かを確認するために、dbを検索する
    @user = User.find_by(email: params[:session][:email].downcase)

    # userがnilでなく、認証できるなら、成功
    # ちなみに、has_secure_passwordをUserモデルに追加したことで、
    # そのオブジェクト内でauthenticateメソッドが使えるようになっている
    if @user && @user.authenticate(params[:session][:password])

      # ユーザーログイン後にユーザー情報のページにリダイレクトする
      # log_inはSessionsHelperで定義されたメソッド
      log_in @user

      # 永続化
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)

      # 以下の実行により、/users/#{user.id}へ飛ばす
      # 次のrailsおよびrubyのルール等により、redirect_to user
      # と書くだけで良い！
      # * 絶対パスへはuser_url(@user.id)で求めることが出来る
      # * リンクのパスとしてモデルオブジェクトが渡されると自動で
      #   idにリンクされるので、.idを省略可
      # * _urlヘルパーは、省略できる
      # * Rubyでは、()は省略できる 
      redirect_to @user

    # 認証失敗の場合は、エラー
    else

      # エラーメッセージを作成する
      flash.now[:danger] = 'Invalid email/password combination' 

      # ログイン画面にもどる
      render 'new'

    end
  end

  # セッション削除(log-out)
  def destroy
    # Helperのlog_outメソッドを呼ぶ
    log_out if logged_in?
    # ルートページへ飛ばす。root_urlは、rootのurlを返す。
    #   ちなみに、root_pathは、/を返す。help_pathは、/helpを、、などなど
    redirect_to root_url
  end
end
