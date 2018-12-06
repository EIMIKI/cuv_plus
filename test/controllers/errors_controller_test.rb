require 'test_helper'

class ErrorsControllerTest < ActionDispatch::IntegrationTest
  test "should get session_error" do
    get errors_session_error_url
    assert_response :success
  end

end
