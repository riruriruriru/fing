require "application_system_test_case"

class AnnotationsTest < ApplicationSystemTestCase
  setup do
    @annotation = annotations(:one)
  end

  test "visiting the index" do
    visit annotations_url
    assert_selector "h1", text: "Annotations"
  end

  test "creating a Annotation" do
    visit annotations_url
    click_on "New Annotation"

    fill_in "Comment", with: @annotation.comment
    fill_in "Times", with: @annotation.times
    fill_in "Tutorial", with: @annotation.tutorial_id
    fill_in "User", with: @annotation.user_id
    click_on "Create Annotation"

    assert_text "Annotation was successfully created"
    click_on "Back"
  end

  test "updating a Annotation" do
    visit annotations_url
    click_on "Edit", match: :first

    fill_in "Comment", with: @annotation.comment
    fill_in "Times", with: @annotation.times
    fill_in "Tutorial", with: @annotation.tutorial_id
    fill_in "User", with: @annotation.user_id
    click_on "Update Annotation"

    assert_text "Annotation was successfully updated"
    click_on "Back"
  end

  test "destroying a Annotation" do
    visit annotations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Annotation was successfully destroyed"
  end
end
