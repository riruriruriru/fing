require 'test_helper'

class StudentannotationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @studentannotation = studentannotations(:one)
  end

  test "should get index" do
    get studentannotations_url
    assert_response :success
  end

  test "should get new" do
    get new_studentannotation_url
    assert_response :success
  end

  test "should create studentannotation" do
    assert_difference('Studentannotation.count') do
      post studentannotations_url, params: { studentannotation: { comment: @studentannotation.comment, statusannotation_id: @studentannotation.statusannotation_id, times: @studentannotation.times, typeannotation_id: @studentannotation.typeannotation_id, user_id: @studentannotation.user_id } }
    end

    assert_redirected_to studentannotation_url(Studentannotation.last)
  end

  test "should show studentannotation" do
    get studentannotation_url(@studentannotation)
    assert_response :success
  end

  test "should get edit" do
    get edit_studentannotation_url(@studentannotation)
    assert_response :success
  end

  test "should update studentannotation" do
    patch studentannotation_url(@studentannotation), params: { studentannotation: { comment: @studentannotation.comment, statusannotation_id: @studentannotation.statusannotation_id, times: @studentannotation.times, typeannotation_id: @studentannotation.typeannotation_id, user_id: @studentannotation.user_id } }
    assert_redirected_to studentannotation_url(@studentannotation)
  end

  test "should destroy studentannotation" do
    assert_difference('Studentannotation.count', -1) do
      delete studentannotation_url(@studentannotation)
    end

    assert_redirected_to studentannotations_url
  end
end
