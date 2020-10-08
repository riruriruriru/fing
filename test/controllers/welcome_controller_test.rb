require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "should get dashboard" do
    get welcome_dashboard_url
    assert_response :success
  end

end
