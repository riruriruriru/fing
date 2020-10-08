require "application_system_test_case"

class TypetutorialsTest < ApplicationSystemTestCase
  setup do
    @typetutorial = typetutorials(:one)
  end

  test "visiting the index" do
    visit typetutorials_url
    assert_selector "h1", text: "Typetutorials"
  end

  test "creating a Typetutorial" do
    visit typetutorials_url
    click_on "New Typetutorial"

    fill_in "Tutorial", with: @typetutorial.tutorial_id
    fill_in "Type", with: @typetutorial.type_id
    click_on "Create Typetutorial"

    assert_text "Typetutorial was successfully created"
    click_on "Back"
  end

  test "updating a Typetutorial" do
    visit typetutorials_url
    click_on "Edit", match: :first

    fill_in "Tutorial", with: @typetutorial.tutorial_id
    fill_in "Type", with: @typetutorial.type_id
    click_on "Update Typetutorial"

    assert_text "Typetutorial was successfully updated"
    click_on "Back"
  end

  test "destroying a Typetutorial" do
    visit typetutorials_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Typetutorial was successfully destroyed"
  end
end
