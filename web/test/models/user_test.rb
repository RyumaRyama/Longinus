require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  test "User認証されている" do
    assert @user.valid?
  end

  test "nameが存在する" do
    @user.name = "     "
    assert_not @user.valid?
  end

  test "emailが存在する" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "nameが長すぎない" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "emailが長すぎない" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "emailの認証では，有効なアドレスのみを受け付ける" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "emailアドレスが一意である" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "passwordが空白でない" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "passwordが少なすぎない" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end
