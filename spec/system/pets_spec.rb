require "rails_helper"

RSpec.describe "Pet show page", type: :system do
  before do
    driven_by(:rack_test)
  end

  def create_pet_luna
    create(:pet,
      name: "Luna",
      breed: "Mixed Breed",
      species: :dog,
      age: 2,
      status: :available,
      description: "A sweet and gentle girl who loves cuddles and long walks.",
      vaccinated: true,
      spayed_neutered: true,
      microchipped: true)
  end

  describe "visiting the show page" do
    it "displays the pet's name and breed" do
      pet = create_pet_luna

      visit pet_path(pet)

      expect(page).to have_content("Luna")
      expect(page).to have_content("Mixed Breed")
    end

    it "displays the pet's status" do
      pet = create_pet_luna

      visit pet_path(pet)

      expect(page).to have_content("Available")
    end

    it "displays the pet's species and age" do
      pet = create_pet_luna

      visit pet_path(pet)

      expect(page).to have_content("Dog")
      expect(page).to have_content("2 years")
    end

    it "displays the about section with description" do
      pet = create_pet_luna

      visit pet_path(pet)

      expect(page).to have_content("About Luna")
      expect(page).to have_content("A sweet and gentle girl who loves cuddles and long walks.")
    end

    it "displays the apply to adopt button" do
      pet = create_pet_luna

      visit pet_path(pet)

      expect(page).to have_link("Apply to Adopt Luna")
    end

    it "displays the contact email" do
      pet = create_pet_luna

      visit pet_path(pet)

      expect(page).to have_content("adopt@casaxolo.org")
    end

    it "displays a photo when the pet has one attached" do
      pet = create(:pet, :with_photo, name: "Salem", status: :available)

      visit pet_path(pet)

      expect(page).to have_css("img[alt='Salem']")
    end

    it "displays a placeholder when the pet has no photo" do
      pet = create_pet_luna

      visit pet_path(pet)

      expect(page).to have_css(".pet-show__photo--placeholder")
    end
  end

  describe "adoption information section" do
    it "shows static adoption information" do
      pet = create_pet_luna

      visit pet_path(pet)

      expect(page).to have_content("Adoption Information")
      expect(page).to have_content("All of our animals are:")
      expect(page).to have_content("Veterinary examined")
      expect(page).to have_content("Up-to-date on vaccinations")
      expect(page).to have_content("Spayed or neutered")
      expect(page).to have_content("Microchipped for identification")
    end
  end

  describe "navigation" do
    it "has a back to all pets link" do
      pet = create_pet_luna

      visit pet_path(pet)

      expect(page).to have_link("Back to All Pets", href: pets_path)
    end

    it "links from home page pet cards to the show page" do
      pet = create_pet_luna

      visit "/"

      click_link pet.name

      expect(page).to have_current_path(pet_path(pet))
      expect(page).to have_content("About Luna")
    end
  end
end
