require "application_system_test_case"

class StudentTutorialsTest < ApplicationSystemTestCase
  setup do
    @student_tutorial = student_tutorials(:one)
  end

  test "visiting the index" do
    visit student_tutorials_url
    assert_selector "h1", text: "Student Tutorials"
  end

  test "creating a Student tutorial" do
    visit student_tutorials_url
    click_on "New Student Tutorial"

    click_on "Create Student tutorial"

    assert_text "Student tutorial was successfully created"
    click_on "Back"
  end

  test "updating a Student tutorial" do
    visit student_tutorials_url
    click_on "Edit", match: :first

    click_on "Update Student tutorial"

    assert_text "Student tutorial was successfully updated"
    click_on "Back"
  end

  test "destroying a Student tutorial" do
    visit student_tutorials_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Student tutorial was successfully destroyed"
  end
end
