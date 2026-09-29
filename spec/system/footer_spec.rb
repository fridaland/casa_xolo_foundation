require "rails_helper"

RSpec.describe "Site footer", type: :system do
  before { driven_by(:rack_test) }

  it "appears on public pages" do
    visit "/"
    expect(page).to have_css("footer.site-footer")
  end

  it "does not appear on admin pages" do
    user = create(:user)
    login_as(user, scope: :user)
    visit "/admin"
    expect(page).not_to have_css("footer.site-footer")
  end

  it "shows the brand name" do
    visit "/"
    within("footer.site-footer") { expect(page).to have_content("Casa Xolo") }
  end

  it "shows quick links" do
    visit "/"
    within("footer.site-footer") do
      expect(page).to have_link("About")
      expect(page).to have_link("Adoptable Pets")
      expect(page).to have_link("Volunteer")
      expect(page).to have_link("Events")
    end
  end

  it "shows the contact email" do
    visit "/"
    within("footer.site-footer") do
      expect(page).to have_link("contact@casaxolofoundation.org")
    end
  end

  it "shows the Instagram link" do
    visit "/"
    within("footer.site-footer") do
      expect(page).to have_link(href: "https://www.instagram.com/casa_xolo_foundation")
    end
  end

  it "shows the copyright notice" do
    visit "/"
    within("footer.site-footer") do
      expect(page).to have_content("Casa Xolo Foundation")
      expect(page).to have_content("All rights reserved")
    end
  end
end
