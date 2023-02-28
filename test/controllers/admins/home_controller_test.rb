require "test_helper"

class Admins::HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admins_home_index_url
    assert_response :success
  end
end
