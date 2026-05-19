require "rails_helper"

RSpec.describe "About page", type: :system do
  before do
    driven_by(:rack_test)
  end

  it "shows the about content" do
    visit "/about"

    expect(page).to have_content("About Casa Xolo")
  end
end
