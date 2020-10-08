require "application_system_test_case"

class DesertionsTest < ApplicationSystemTestCase
  setup do
    @desertion = desertions(:one)
  end

  test "visiting the index" do
    visit desertions_url
    assert_selector "h1", text: "Desertions"
  end

  test "creating a Desertion" do
    visit desertions_url
    click_on "New Desertion"

    click_on "Create Desertion"

    assert_text "Desertion was successfully created"
    click_on "Back"
  end

  test "updating a Desertion" do
    visit desertions_url
    click_on "Edit", match: :first

    click_on "Update Desertion"

    assert_text "Desertion was successfully updated"
    click_on "Back"
  end

  test "destroying a Desertion" do
    visit desertions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Desertion was successfully destroyed"
  end
end
