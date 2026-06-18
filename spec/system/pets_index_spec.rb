require "rails_helper"

RSpec.describe "Pets index page", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "pet grid" do
    it "shows available pets" do
      create(:pet, name: "Luna", breed: "Mixed Breed", status: :available)
      create(:pet, name: "Simba", breed: "Domestic Shorthair", status: :available)

      visit pets_path

      expect(page).to have_content("Luna")
      expect(page).to have_content("Mixed Breed")
      expect(page).to have_content("Simba")
    end

    it "shows urgent pets" do
      create(:pet, name: "Bruno", status: :urgent)

      visit pets_path

      expect(page).to have_content("Bruno")
    end

    it "does not show adopted pets" do
      create(:pet, name: "Adopted Andy", status: :adopted)

      visit pets_path

      expect(page).not_to have_content("Adopted Andy")
    end

    it "shows a photo when the pet has one attached" do
      create(:pet, :with_photo, name: "Salem", status: :available)

      visit pets_path

      expect(page).to have_css("img[alt='Salem']")
    end

    it "shows the pet count" do
      create(:pet, name: "Luna", status: :available)
      create(:pet, name: "Simba", status: :available)
      create(:pet, name: "Bruno", status: :urgent)

      visit pets_path

      expect(page).to have_content("Showing 3 pets")
    end

    it "links pet cards to the show page" do
      pet = create(:pet, name: "Luna", status: :available)

      visit pets_path

      click_link "Luna"

      expect(page).to have_current_path(pet_path(pet))
    end
  end

  describe "filters" do
    it "filters by species" do
      create(:pet, name: "Luna", species: :dog, status: :available)
      create(:pet, name: "Simba", species: :cat, status: :available)

      visit pets_path(species: "cat")

      expect(page).to have_content("Simba")
      expect(page).not_to have_content("Luna")
    end

    it "filters by status" do
      create(:pet, name: "Luna", status: :available)
      create(:pet, name: "Bruno", status: :urgent)

      visit pets_path(status: "urgent")

      expect(page).to have_content("Bruno")
      expect(page).not_to have_content("Luna")
    end

    it "updates the pet count when filtered" do
      create(:pet, name: "Luna", species: :dog, status: :available)
      create(:pet, name: "Simba", species: :cat, status: :available)

      visit pets_path(species: "dog")

      expect(page).to have_content("Showing 1 pet")
    end

    it "shows filter dropdowns" do
      visit pets_path

      expect(page).to have_select("species")
      expect(page).to have_select("status")
    end
  end

  describe "adoption process section" do
    it "shows the adoption process steps" do
      visit pets_path

      expect(page).to have_content("Adoption Process")
      expect(page).to have_content("Browse our available pets")
      expect(page).to have_content("Submit an adoption application")
    end
  end

  describe "navigation" do
    it "is linked from the nav bar" do
      visit "/"

      click_link "Adoptable Pets"

      expect(page).to have_current_path(pets_path)
    end

    it "is linked from the home page CTA" do
      visit "/"

      click_link "View All Adoptable Pets"

      expect(page).to have_current_path(pets_path)
    end
  end
end
