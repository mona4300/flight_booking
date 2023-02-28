require "application_system_test_case"

class AeroplanesTest < ApplicationSystemTestCase
  setup do
    @aeroplane = aeroplanes(:one)
  end

  test "visiting the index" do
    visit aeroplanes_url
    assert_selector "h1", text: "Aeroplanes"
  end

  test "should create aeroplane" do
    visit aeroplanes_url
    click_on "New aeroplane"

    fill_in "Name", with: @aeroplane.name
    click_on "Create Aeroplane"

    assert_text "Aeroplane was successfully created"
    click_on "Back"
  end

  test "should update Aeroplane" do
    visit aeroplane_url(@aeroplane)
    click_on "Edit this aeroplane", match: :first

    fill_in "Name", with: @aeroplane.name
    click_on "Update Aeroplane"

    assert_text "Aeroplane was successfully updated"
    click_on "Back"
  end

  test "should destroy Aeroplane" do
    visit aeroplane_url(@aeroplane)
    click_on "Destroy this aeroplane", match: :first

    assert_text "Aeroplane was successfully destroyed"
  end
end
