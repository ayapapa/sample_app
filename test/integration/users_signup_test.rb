require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "invalid signup information" do
    get signup_path
    # post（が失敗するので）後にUser.countが不変であることをテストする
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    # user/newがviewされることをテストする
    assert_template 'users/new'
    # URLをテストする
    #assert_select 'form[action="/signup"]' 下の書き方のほうが良いのかな？
    assert_select 'form[action=?]', "/signup"
    # 表示されたページにエラーメッセージタグの存在をテストする
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
    assert_select 'div.alert-danger'
    assert_select 'ul/li'
    # alertクラスのdivタグが、文字列"The form contains"を含んでいることをテストする
    assert_select "div.alert", /The form contains/
    # alertクラスのdivタグが、文字列"error"を含んでいることをテストする
    assert_select "div.alert", /error/
    # flashが空であることをテストする
    assert flash.empty?
  end

  # 正常なサインアップテスト
  test "valid signup information" do
    get signup_path
    # 実行後にカウントが1増えている（差分がある）ことをテストする
    # テストが完了(rails testが終了)するとテスト用DBはリセットされる?
    # ので、下記テストは常に成功する
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    # postの結果で指定されたリダイレクト先（成功の場合は、users/showのはず）へ移動する
    follow_redirect!
    # 移動先が、users/showテンプレートに一致しているか否かをテストする
    assert_template 'users/show'
    # flash内容をテストする
    assert_select 'div.alert-success', "Welcome to the Sample App!"
    assert_not flash.empty?
  end

end
