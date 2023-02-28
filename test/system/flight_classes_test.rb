require "application_system_test_case"

class FlightClassesTest < ApplicationSystemTestCase
  setup do
    @flight_class = flight_classes(:one)
  end

  test "visiting the index" do
    visit flight_classes_url
    assert_selector "h1", text: "Flight classes"
  end

  test "should create flight class" do
    visit flight_classes_url
    click_on "New flight class"

    click_on "Create Flight class"

    assert_text "Flight class was successfully created"
    click_on "Back"
  end

  test "should update Flight class" do
    visit flight_class_url(@flight_class)
    click_on "Edit this flight class", match: :first

    click_on "Update Flight class"

    assert_text "Flight class was successfully updated"
    click_on "Back"
  end

  test "should destroy Flight class" do
    visit flight_class_url(@flight_class)
    click_on "Destroy this flight class", match: :first

    assert_text "Flight class was successfully destroyed"
  end
end
