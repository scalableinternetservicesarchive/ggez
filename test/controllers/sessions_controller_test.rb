require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get login url" do
    get login_url
    assert_response :success
  end

end
