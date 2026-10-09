require "rails_helper"

RSpec.describe "Admin::Placements", type: :system do
  before { driven_by(:rack_test) }

  let(:user) { create(:user) }

  describe "index page" do
    it "shows the placements table with expected column headers" do
      login_as user
      visit "/admin/placements"

      expect(page).to have_content("Parent")
      expect(page).to have_content("Pet")
      expect(page).to have_content("Placement Type")
      expect(page).to have_content("Pet Placement Status")
      expect(page).to have_content("Status")
      expect(page).to have_content("Start Date")
    end

    it "lists existing placements with parent and pet details" do
      pet = create(:pet, name: "Bella")
      parent = create(:parent, family_name: "Martinez Family")
      create(:placement, parent: parent, pet: pet, placement_type: :foster, status: :active,
        start_date: Date.new(2023, 6, 15))

      login_as user
      visit "/admin/placements"

      expect(page).to have_content("Martinez Family")
      expect(page).to have_content("Bella")
      expect(page).to have_content("In Foster Care")
    end
  end

  describe "creating a placement" do
    it "creates a foster placement" do
      create(:pet, name: "Luna")
      create(:parent, family_name: "Chen Family")

      login_as user
      visit "/admin/placements"
      click_on "New placement"

      select "Chen Family", from: "Parent"
      select "Luna", from: "Pet"
      select "foster", from: "Placement type"
      select "active", from: "Status"
      fill_in "Start date", with: "2023-08-10"

      click_on "Create Placement"

      expect(page).to have_content("Chen Family")
      expect(page).to have_content("Luna")
      expect(page).to have_content("Foster")
      expect(page).to have_content("In Foster Care")
    end

    it "creates an adoptive placement" do
      create(:pet, name: "Max")
      create(:parent, family_name: "Johnson Home")

      login_as user
      visit "/admin/placements"
      click_on "New placement"

      select "Johnson Home", from: "Parent"
      select "Max", from: "Pet"
      select "adoptive", from: "Placement type"
      select "completed", from: "Status"
      fill_in "Start date", with: "2023-07-20"

      click_on "Create Placement"

      visit "/admin/placements"
      expect(page).to have_content("Johnson Home")
      expect(page).to have_content("Adopted")
    end
  end

  describe "show page" do
    it "displays all placement details" do
      pet = create(:pet, name: "Rocky")
      parent = create(:parent, family_name: "Rodriguez Home")
      placement = create(:placement, :adoptive, :completed, parent: parent, pet: pet,
        start_date: Date.new(2023, 9, 5))

      login_as user
      visit "/admin/placements/#{placement.id}"

      expect(page).to have_content("Rodriguez Home")
      expect(page).to have_content("Rocky")
      expect(page).to have_content("Adoptive")
      expect(page).to have_content("Completed")
      expect(page).to have_content("Adopted")
    end
  end
end
