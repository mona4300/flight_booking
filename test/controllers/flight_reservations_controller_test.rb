require "test_helper"

class FlightReservationsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get flight_reservations_show_url
    assert_response :success
  end

  test "should get edit" do
    get flight_reservations_edit_url
    assert_response :success
  end

  test "should get update" do
    get flight_reservations_update_url
    assert_response :success
  end
end
