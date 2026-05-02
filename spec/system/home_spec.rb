require "rails_helper"

RSpec.describe "Homepage", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "pets section" do
    it "shows available pets" do
      create(:pet, name: "Luna", breed: "Mixed Breed", status: :available)
      create(:pet, name: "Simba", breed: "Domestic Shorthair", status: :available)

      visit "/"

      expect(page).to have_content("Luna")
      expect(page).to have_content("Mixed Breed")
      expect(page).to have_content("Simba")
      expect(page).to have_content("Domestic Shorthair")
    end

    it "does not show non-available pets" do
      create(:pet, name: "Adopted Andy", status: :adopted)

      visit "/"

      expect(page).not_to have_content("Adopted Andy")
    end

    it "shows the View All Adoptable Pets link" do
      visit "/"

      expect(page).to have_link("View All Adoptable Pets")
    end

    it "shows a photo when the pet has one attached" do
      create(:pet, :with_photo, name: "Salem")

      visit "/"

      expect(page).to have_css("img[alt='Salem']")
    end

    it "shows a placeholder when the pet has no photo" do
      create(:pet, name: "No Photo Pete")

      visit "/"

      expect(page).to have_css(".pet-card__photo--placeholder")
    end
  end

  describe "events section" do
    it "shows upcoming events" do
      create(:event, name: "Community Adoption Day", location: "Casa Xolo HQ", event_date: 1.week.from_now)

      visit "/"

      expect(page).to have_content("Community Adoption Day")
      expect(page).to have_content("Casa Xolo HQ")
    end

    it "does not show past events" do
      create(:event, name: "Old Fundraiser", event_date: 1.day.ago)

      visit "/"

      expect(page).not_to have_content("Old Fundraiser")
    end

    it "shows events ordered by date ascending" do
      create(:event, name: "Later Event", event_date: 3.weeks.from_now)
      create(:event, name: "Sooner Event", event_date: 1.week.from_now)

      visit "/"

      expect(page.body.index("Sooner Event")).to be < page.body.index("Later Event")
    end

    it "shows the View All Events link" do
      visit "/"

      expect(page).to have_link("View All Events")
    end
  end
end
