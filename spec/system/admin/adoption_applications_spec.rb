require "rails_helper"

RSpec.describe "Admin::AdoptionApplications", type: :system do
  before { driven_by(:rack_test) }

  let(:user) { create(:user) }
  let(:pet) { create(:pet, name: "Bella") }

  describe "show page" do
    context "when application is pending" do
      let(:application) { create(:adoption_application, pet: pet, status: "pending") }

      it "shows an Approve button" do
        login_as user
        visit "/admin/adoption_applications/#{application.id}"
        expect(page).to have_button("Approve")
      end

      it "shows application_type on the page" do
        login_as user
        visit "/admin/adoption_applications/#{application.id}"
        expect(page).to have_content("Application type")
      end
    end

    context "when application is already approved" do
      let(:application) { create(:adoption_application, pet: pet, status: "approved") }

      it "does not show the Approve button" do
        login_as user
        visit "/admin/adoption_applications/#{application.id}"
        expect(page).not_to have_button("Approve")
      end
    end
  end

  describe "POST approve" do
    let(:application) { create(:adoption_application, :foster, pet: pet) }

    it "approves the application and creates a parent and placement" do
      login_as user
      visit "/admin/adoption_applications/#{application.id}"

      expect { click_button "Approve" }.to change(Parent, :count).by(1)
        .and change(Placement, :count).by(1)

      expect(application.reload.status).to eq("approved")
    end

    it "redirects to the show page with a success notice" do
      login_as user
      visit "/admin/adoption_applications/#{application.id}"
      click_button "Approve"

      expect(page).to have_current_path("/admin/adoption_applications/#{application.id}")
      expect(page).to have_content("successfully updated")
    end

    it "does not show the Approve button after approval" do
      login_as user
      visit "/admin/adoption_applications/#{application.id}"
      click_button "Approve"

      expect(page).not_to have_button("Approve")
    end
  end
end
