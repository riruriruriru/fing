require 'test_helper'

class DesertionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @desertion = desertions(:one)
  end

  test "should get index" do
    get desertions_url
    assert_response :success
  end

  test "should get new" do
    get new_desertion_url
    assert_response :success
  end

  test "should create desertion" do
    assert_difference('Desertion.count') do
      post desertions_url, params: { desertion: {  } }
    end

    assert_redirected_to desertion_url(Desertion.last)
  end

  test "should show desertion" do
    get desertion_url(@desertion)
    assert_response :success
  end

  test "should get edit" do
    get edit_desertion_url(@desertion)
    assert_response :success
  end

  test "should update desertion" do
    patch desertion_url(@desertion), params: { desertion: {  } }
    assert_redirected_to desertion_url(@desertion)
  end

  test "should destroy desertion" do
    assert_difference('Desertion.count', -1) do
      delete desertion_url(@desertion)
    end

    assert_redirected_to desertions_url
  end
end
