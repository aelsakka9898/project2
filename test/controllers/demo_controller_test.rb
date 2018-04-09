require 'test_helper'

class DemoControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get demo_new_url
    assert_response :success
  end

end
