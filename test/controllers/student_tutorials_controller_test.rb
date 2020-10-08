require 'test_helper'

class StudentTutorialsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @student_tutorial = student_tutorials(:one)
  end

  test "should get index" do
    get student_tutorials_url
    assert_response :success
  end

  test "should get new" do
    get new_student_tutorial_url
    assert_response :success
  end

  test "should create student_tutorial" do
    assert_difference('StudentTutorial.count') do
      post student_tutorials_url, params: { student_tutorial: {  } }
    end

    assert_redirected_to student_tutorial_url(StudentTutorial.last)
  end

  test "should show student_tutorial" do
    get student_tutorial_url(@student_tutorial)
    assert_response :success
  end

  test "should get edit" do
    get edit_student_tutorial_url(@student_tutorial)
    assert_response :success
  end

  test "should update student_tutorial" do
    patch student_tutorial_url(@student_tutorial), params: { student_tutorial: {  } }
    assert_redirected_to student_tutorial_url(@student_tutorial)
  end

  test "should destroy student_tutorial" do
    assert_difference('StudentTutorial.count', -1) do
      delete student_tutorial_url(@student_tutorial)
    end

    assert_redirected_to student_tutorials_url
  end
end
