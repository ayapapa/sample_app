module UsersHelper

  # 引数で与えられたユーザーのGravatar画像を返す
  def gravatar_for(user, size: 80)

    # メールからハッシュの値を求め、gravatarのidとする
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)

    # urlを作成(ex. "https://secure.gravatar.com/avatar/23jkosoohogehoge?s=80"
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"

    # イメージタグを作成する
    # image_tagは、ActionView::Helpers::AssetTagHelperクラスのメソッド
    image_tag(gravatar_url, alt: user.name, class: "gravatar")

  end
end
