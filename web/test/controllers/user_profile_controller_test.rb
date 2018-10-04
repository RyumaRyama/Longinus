require 'test_helper'

class UserProfileControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get user_profile_home_url
    assert_response :success
  end

  test "should get help" do
    get user_profile_help_url
    assert_response :success
  end

  test "should get ryama" do
    get user_profile_help_url
    assert_response :success
  end
  
  test "should get kame" do
    get user_profile_home_url
    assert_response :success
  end
  
end
