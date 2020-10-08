require 'test_helper'

class TypetutorialsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @typetutorial = typetutorials(:one)
  end

  test "should get index" do
    get typetutorials_url
    assert_response :success
  end

  test "should get new" do
    get new_typetutorial_url
    assert_response :success
  end

  test "should create typetutorial" do
    assert_difference('Typetutorial.count') do
      post typetutorials_url, params: { typetutorial: { tutorial_id: @typetutorial.tutorial_id, type_id: @typetutorial.type_id } }
    end

    assert_redirected_to typetutorial_url(Typetutorial.last)
  end

  test "should show typetutorial" do
    get typetutorial_url(@typetutorial)
    assert_response :success
  end

  test "should get edit" do
    get edit_typetutorial_url(@typetutorial)
    assert_response :success
  end

  test "should update typetutorial" do
    patch typetutorial_url(@typetutorial), params: { typetutorial: { tutorial_id: @typetutorial.tutorial_id, type_id: @typetutorial.type_id } }
    assert_redirected_to typetutorial_url(@typetutorial)
  end

  test "should destroy typetutorial" do
    assert_difference('Typetutorial.count', -1) do
      delete typetutorial_url(@typetutorial)
    end

    assert_redirected_to typetutorials_url
  end
end
