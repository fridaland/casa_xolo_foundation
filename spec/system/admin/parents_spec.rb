require "rails_helper"

RSpec.describe "Admin::Parents", type: :system do
  before { driven_by(:rack_test) }

  let(:user) { create(:user) }

  describe "index page" do
    it "shows the parents table with family info columns" do
      login_as user
      visit "/admin/parents"

      expect(page).to have_content("Family Name")
      expect(page).to have_content("Primary Contact Name")
      expect(page).to have_content("Primary Contact Email")
    end

    it "lists existing parents" do
      create(:parent, family_name: "Martinez Family",
        primary_contact_name: "Ana Martinez",
        primary_contact_email: "ana@example.com")

      login_as user
      visit "/admin/parents"

      expect(page).to have_content("Martinez Family")
      expect(page).to have_content("Ana Martinez")
    end
  end

  describe "creating a parent" do
    it "creates a new family record" do
      login_as user
      visit "/admin/parents"
      click_on "New parent"

      fill_in "Family name", with: "Chen Family"
      fill_in "Primary contact name", with: "Wei Chen"
      fill_in "Primary contact email", with: "wei@example.com"

      click_on "Create Parent"

      expect(page).to have_content("Chen Family")
    end
  end
end
