require "test_helper"

class AeroplaneClassesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @aeroplane_class = aeroplane_classes(:one)
  end

  test "should get index" do
    get aeroplane_classes_url
    assert_response :success
  end

  test "should get new" do
    get new_aeroplane_class_url
    assert_response :success
  end

  test "should create aeroplane_class" do
    assert_difference("AeroplaneClass.count") do
      post aeroplane_classes_url, params: { aeroplane_class: {  } }
    end

    assert_redirected_to aeroplane_class_url(AeroplaneClass.last)
  end

  test "should show aeroplane_class" do
    get aeroplane_class_url(@aeroplane_class)
    assert_response :success
  end

  test "should get edit" do
    get edit_aeroplane_class_url(@aeroplane_class)
    assert_response :success
  end

  test "should update aeroplane_class" do
    patch aeroplane_class_url(@aeroplane_class), params: { aeroplane_class: {  } }
    assert_redirected_to aeroplane_class_url(@aeroplane_class)
  end

  test "should destroy aeroplane_class" do
    assert_difference("AeroplaneClass.count", -1) do
      delete aeroplane_class_url(@aeroplane_class)
    end

    assert_redirected_to aeroplane_classes_url
  end
end
