require "application_system_test_case"

class AeroplaneClassesTest < ApplicationSystemTestCase
  setup do
    @aeroplane_class = aeroplane_classes(:one)
  end

  test "visiting the index" do
    visit aeroplane_classes_url
    assert_selector "h1", text: "Aeroplane classes"
  end

  test "should create aeroplane class" do
    visit aeroplane_classes_url
    click_on "New aeroplane class"

    click_on "Create Aeroplane class"

    assert_text "Aeroplane class was successfully created"
    click_on "Back"
  end

  test "should update Aeroplane class" do
    visit aeroplane_class_url(@aeroplane_class)
    click_on "Edit this aeroplane class", match: :first

    click_on "Update Aeroplane class"

    assert_text "Aeroplane class was successfully updated"
    click_on "Back"
  end

  test "should destroy Aeroplane class" do
    visit aeroplane_class_url(@aeroplane_class)
    click_on "Destroy this aeroplane class", match: :first

    assert_text "Aeroplane class was successfully destroyed"
  end
end
