require 'rails_helper'

RSpec.feature "Patient Management", type: :feature do
  let!(:user) { create(:user, :receptionist) }  # Create a user for testing
  let!(:patient) { Patient.create(name: "John Doe", age: 30, gender: "Male") }

  before do
    login_as(user, scope: :user)  # Ensure the user is logged in
  end

  scenario "User creates a new patient" do
    visit new_patient_path

    expect(page).to have_content("New Patient")  # Verify the form is loaded
    fill_in "Name", with: "Jane Smith"
    fill_in "Age", with: 28
    fill_in "Gender", with: "Female"
    click_button "Create Patient"

    expect(page).to have_content("Patient was successfully created.")
    expect(page).to have_content("Jane Smith")
  end

  scenario "User views patient stats" do
    visit stats_patients_path

    expect(page).to have_content("Patient Registration Stats")
  end

  scenario "User searches for a patient" do
    visit patients_path

    fill_in "Search Patients", with: "John"
    click_button "Search"

    expect(page).to have_content("John Doe")
  end
end
