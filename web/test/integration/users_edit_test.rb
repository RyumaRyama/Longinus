require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  # test "unsuccessful edit" do
  #   log_in_as(@user)
  #   get edit_user_profile_path(@user)
  #   # assert_template edit_user_profile
  #   patch user_profile_path(@user), params: { user: { name:  "",
  #                                             # test "the truth" do
  #                                             email: "foo@invalid",
  #                                             password:              "foo",
  #                                             password_confirmation: "bar" } }
  #
  #   assert_template edit_user_profile
  # end
  #
  # test "successful edit" do
  #   log_in_as(@user)
  #   get edit_user_profile_path(@user)
  #   # assert_template 'user_profile/edit'
  #   name  = "Foo Bar"
  #   email = "foo@bar.com"
  #   patch user_profile_path(@user), params: { user: { name:  name,
  #                                             email: email,
  #                                             password:              "",
  #                                             password_confirmation: "" } }
  #   assert_not flash.empty?
  #   assert_redirected_to user_profile_path(id: @user.id)
  #   @user.reload
  #   assert_equal name,  @user.name
  #   assert_equal email, @user.email
  # end
end
