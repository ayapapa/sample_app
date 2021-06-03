class UsersController < ApplicationController
  # GET /users/id
  def show
    @user = User.find(params[:id])
    #デバッガ―をコンソールで実行できる！！
    #debugger
  end

  # "rails generate controller Users new"で生成
  def new
    @user = User.new
    #debugger
  end

  def create
    @user = User.new(user_params)
    #debugger
    if @user.save
      # 登録成功なので、ログインする
      log_in @user
      # flashを設定する。次のリダイレクト先でflashをアクセス可能となる。
      flash[:success] = "Welcome to the Sample App!"

      # 以下は、redirect_to("/users/#{@user.id}")と同じ意味
      # @userに飛ばしたいって？んじゃぁ、users_urlに、@user.idを渡すってことだね？OK　ってな感じ
      # ちなみに、users_urlときたら、"/users"と解釈してくれる。
      redirect_to @user
    else
      render 'new'
    end
  end

  private
    # ユーザーオブジェクトのうち、更新可能なパラメータを制限
    # 他のパラメータ（キー）は無視される(セキュリティ担保)
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

end
