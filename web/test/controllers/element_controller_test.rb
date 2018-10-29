require 'test_helper'

class ElementControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get element_new_url
    assert_response :success
  end

  test "should get update" do
    get element_update_url
    assert_response :success
  end

end
