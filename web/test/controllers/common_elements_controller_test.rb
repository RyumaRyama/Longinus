require 'test_helper'

class CommonElementsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get common_elements_show_url
    assert_response :success
  end

end
