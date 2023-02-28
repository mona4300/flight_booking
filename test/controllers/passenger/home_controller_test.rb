require "test_helper"

class Passenger::HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get passenger_home_index_url
    assert_response :success
  end
end
