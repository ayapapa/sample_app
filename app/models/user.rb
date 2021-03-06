#
# ユーザーモデル定義
#
# 生成に利用したrailsコマンド
# rails generate model User name:string email:string
# rails generate migration add_index_to_users_email
# rails generate migration add_password_digest_to_users password_digest:string
# rails generate migration add_remember_digest_to_users remember_digest:string
class User < ApplicationRecord
  # ユーザートークン記憶のためのメンバ変数
  attr_accessor :remember_token

  # データ保存前にメアド文字列をすべて小文字に変換する
  # これは、DB内で大文字小文字を区別を無くすため（メアドというものはそういうものなので）
  # ちなみに、下記式は、self.email = email.downcase と同じ
  before_save { email.downcase! }
  # 名前は必ず存在し、長さは50文字以下とする
  validates :name,  presence: true, length: { maximum: 50 }
  # メアドの正規表現(メアドの正当性をチェックするために定義)
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  # メアドは必ず存在、最大文字列長255文字、形式を上記正規表現で限定、かつ、
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  # セキュアなpassword
  has_secure_password
  validates :password, length: { minimum: 6 }, presence: true

  # クラスメソッド
  #  static methodのようなもの
  #  User.digest("test")と呼べるが、
  #  user=User.first, user.digest("test")とは呼べない
  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    # test等にて最小コストを要求されることを想定し、その場合は最小コストとする
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    # ハッシュ値（ダイジェスト）を求める
    BCrypt::Password.create(string, cost: cost)
  end

  # クラスメソッド
  # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # インスタンスメソッド
  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    # DBにremember_digestが無い(nil)の場合は、ログインしていない状態なので、
    # falseを返す。
    return false if remember_digest.nil?

    # DBのremember_digest値をハッシュ値として渡したpasswordインスタンス
    # で、本メソッドの引数であるremember_tokenがpassword(のハッシュ値)と
    # 合致するか否かをチェック
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # ユーザーのログイン情報を破棄する
  def forget
    # DBの永続用ダイジェストを削除する
    update_attribute(:remember_digest, nil)
  end

end
