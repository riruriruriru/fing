require "application_system_test_case"

class StudentannotationsTest < ApplicationSystemTestCase
  setup do
    @studentannotation = studentannotations(:one)
  end

  test "visiting the index" do
    visit studentannotations_url
    assert_selector "h1", text: "Studentannotations"
  end

  test "creating a Studentannotation" do
    visit studentannotations_url
    click_on "New Studentannotation"

    fill_in "Comment", with: @studentannotation.comment
    fill_in "Statusannotation", with: @studentannotation.statusannotation_id
    fill_in "Times", with: @studentannotation.times
    fill_in "Typeannotation", with: @studentannotation.typeannotation_id
    fill_in "User", with: @studentannotation.user_id
    click_on "Create Studentannotation"

    assert_text "Studentannotation was successfully created"
    click_on "Back"
  end

  test "updating a Studentannotation" do
    visit studentannotations_url
    click_on "Edit", match: :first

    fill_in "Comment", with: @studentannotation.comment
    fill_in "Statusannotation", with: @studentannotation.statusannotation_id
    fill_in "Times", with: @studentannotation.times
    fill_in "Typeannotation", with: @studentannotation.typeannotation_id
    fill_in "User", with: @studentannotation.user_id
    click_on "Update Studentannotation"

    assert_text "Studentannotation was successfully updated"
    click_on "Back"
  end

  test "destroying a Studentannotation" do
    visit studentannotations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Studentannotation was successfully destroyed"
  end
end
