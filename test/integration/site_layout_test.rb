require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "layout links" do
    get root_path
    # viewの'static_pages/home'が描画されたかをチェックする
    assert_template 'static_pages/home'
    # root(/)へのリンクが2個あることをチェックする
    assert_select "a[href=?]", root_path, count: 2
    # /helpへのリンクがあることをチェックする
    assert_select "a[href=?]", help_path
    # /aboutへのリンクがあることをチェックする
    assert_select "a[href=?]", about_path
    # /contactへのリンクがあることをチェックする
    assert_select "a[href=?]", contact_path
    # divタグの存在をチェックする
    assert_select "div"

    get contact_path
    assert_select "title", full_title("Contact")
  end
end
