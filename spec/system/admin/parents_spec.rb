require "rails_helper"

RSpec.describe "Admin::Parents", type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user) { create(:user) }

  describe "index page" do
    it "shows the parents table with expected column headers" do
      login_as user
      visit "/admin/parents"

      expect(page).to have_content("Family Name")
      expect(page).to have_content("Primary Contact")
      expect(page).to have_content("Parent Type")
      expect(page).to have_content("Pet")
      expect(page).to have_content("Pet Placement Status")
      expect(page).to have_content("Status")
      expect(page).to have_content("Start Date")
    end

    it "lists existing parents with their details" do
      pet = create(:pet, name: "Bella")
      parent = create(:parent,
        family_name: "Martinez Family",
        primary_contact_name: "Ana Martinez",
        primary_contact_email: "ana@example.com",
        parent_type: :foster,
        status: :active,
        start_date: Date.new(2023, 6, 15),
        pet: pet)

      login_as user
      visit "/admin/parents"

      expect(page).to have_content("Martinez Family")
      expect(page).to have_content("Ana Martinez")
      expect(page).to have_content("Bella")
      expect(page).to have_content("In Foster Care")
    end

    it "shows 'Add New Parent' button" do
      login_as user
      visit "/admin/parents"
      expect(page).to have_link("New parent")
    end
  end

  describe "creating a parent" do
    it "creates a foster parent with all fields" do
      pet = create(:pet, name: "Luna")
      login_as user
      visit "/admin/parents"
      click_on "New parent"

      fill_in "Family name", with: "Chen Family"
      fill_in "Primary contact name", with: "Wei Chen"
      fill_in "Primary contact email", with: "wei.chen@example.com"
      select "foster", from: "Parent type"
      select "active", from: "Status"
      fill_in "Start date", with: "2023-08-10"
      select "Luna", from: "Pet"

      click_on "Create Parent"

      expect(page).to have_content("Chen Family")
    end

    it "creates an adoptive parent" do
      pet = create(:pet, name: "Max")
      login_as user
      visit "/admin/parents"
      click_on "New parent"

      fill_in "Family name", with: "Johnson Home"
      fill_in "Primary contact name", with: "Robert Johnson"
      fill_in "Primary contact email", with: "rjohnson@example.com"
      select "adoptive", from: "Parent type"
      select "completed", from: "Status"
      fill_in "Start date", with: "2023-07-20"
      select "Max", from: "Pet"

      click_on "Create Parent"

      expect(page).to have_content("Johnson Home")

      visit "/admin/parents"
      expect(page).to have_content("Johnson Home")
      expect(page).to have_content("Adopted")
    end
  end

  describe "show page" do
    it "displays all parent details" do
      pet = create(:pet, name: "Rocky")
      parent = create(:parent,
        family_name: "Rodriguez Home",
        primary_contact_name: "Carmen Rodriguez",
        primary_contact_email: "carmen@example.com",
        parent_type: :adoptive,
        status: :completed,
        start_date: Date.new(2023, 9, 5),
        pet: pet)

      login_as user
      visit "/admin/parents/#{parent.id}"

      expect(page).to have_content("Rodriguez Home")
      expect(page).to have_content("Carmen Rodriguez")
      expect(page).to have_content("carmen@example.com")
      expect(page).to have_content("Adoptive")
      expect(page).to have_content("Completed")
      expect(page).to have_content("Rocky")
    end
  end
end
