require "test_helper"

class FlightClassesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @flight_class = flight_classes(:one)
  end

  test "should get index" do
    get flight_classes_url
    assert_response :success
  end

  test "should get new" do
    get new_flight_class_url
    assert_response :success
  end

  test "should create flight_class" do
    assert_difference("FlightClass.count") do
      post flight_classes_url, params: { flight_class: {  } }
    end

    assert_redirected_to flight_class_url(FlightClass.last)
  end

  test "should show flight_class" do
    get flight_class_url(@flight_class)
    assert_response :success
  end

  test "should get edit" do
    get edit_flight_class_url(@flight_class)
    assert_response :success
  end

  test "should update flight_class" do
    patch flight_class_url(@flight_class), params: { flight_class: {  } }
    assert_redirected_to flight_class_url(@flight_class)
  end

  test "should destroy flight_class" do
    assert_difference("FlightClass.count", -1) do
      delete flight_class_url(@flight_class)
    end

    assert_redirected_to flight_classes_url
  end
end
