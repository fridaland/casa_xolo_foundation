require "rails_helper"

RSpec.describe "Foster applications", type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:pet) { create(:pet, :fosterable, name: "Luna") }

  def fill_in_foster_form
    fill_in "First Name", with: "Jane"
    fill_in "Last Name", with: "Doe"
    fill_in "Email", with: "jane@example.com"
    fill_in "Phone Number", with: "555-867-5309"
    fill_in "Street Address", with: "123 Main St"
    fill_in "City", with: "Austin"
    fill_in "State", with: "TX"
    fill_in "Zip Code", with: "78701"
    select "House", from: "Type of Housing"
    select "Own", from: "Do you own or rent?"
    select "Yes — fenced", from: "Do you have a yard?"
    select "No", from: "Do you have other pets?"
    select "No", from: "Do you have children?"
    fill_in "Previous pet ownership experience", with: "I have owned dogs my whole life."
    fill_in "Why do you want to foster Luna?", with: "I want to provide a loving temporary home."
  end

  describe "visiting the foster application form" do
    it "shows the foster application title" do
      visit new_pet_foster_application_path(pet)

      expect(page).to have_content("Foster Application")
    end

    it "shows the pet's name as the subtitle" do
      visit new_pet_foster_application_path(pet)

      expect(page).to have_content("for Luna")
    end

    it "labels the reason field with 'foster' copy" do
      visit new_pet_foster_application_path(pet)

      expect(page).to have_content("Why do you want to foster Luna?")
    end

    it "has a back link to the pet's profile" do
      visit new_pet_foster_application_path(pet)

      expect(page).to have_link("Back to Luna's Profile", href: pet_path(pet))
    end
  end

  describe "submitting a valid foster application" do
    it "creates an application with application_type 'foster'" do
      visit new_pet_foster_application_path(pet)
      fill_in_foster_form
      click_button "Submit Application"

      application = AdoptionApplication.last
      expect(application.application_type).to eq("foster")
      expect(application.pet).to eq(pet)
    end

    it "redirects to the thank you page" do
      visit new_pet_foster_application_path(pet)
      fill_in_foster_form
      click_button "Submit Application"

      expect(page).to have_current_path(thank_you_pet_foster_applications_path(pet))
    end
  end

  describe "submitting an invalid foster application" do
    it "shows validation errors without creating a record" do
      visit new_pet_foster_application_path(pet)
      click_button "Submit Application"

      expect(page).to have_content("Please fix the following errors")
      expect(AdoptionApplication.count).to eq(0)
    end

    it "re-renders the form with the foster title intact" do
      visit new_pet_foster_application_path(pet)
      click_button "Submit Application"

      expect(page).to have_content("Foster Application")
    end
  end
end
