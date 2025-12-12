require "rails_helper"

RSpec.describe "Admin::Pets", type: :system do
  before do
    driven_by(:rack_test) # fast, no JS; switch to :selenium if you need JS
  end

  it "allows creating a pet with multiple temperaments" do
    visit "/admin/pets"

    click_on "New pet"

    fill_in "Name", with: "Tater Tot"
    select "dog", from: "Species"
    select "male", from: "Sex"
    select "medium", from: "Size"
    fill_in "Color", with: "Yellow"
    fill_in "Description", with: "A friendly dog looking for a home."

    check "Calm"
    check "Good with kids"
    check "Social"

    select "available", from: "Status"
    check "Spayed neutered"

    click_on "Create Pet"

    expect(page).to have_content("Tater Tot")

    click_on "Tater Tot"
    expect(page).to have_content("Calm")
    expect(page).to have_content("Good with kids")
    expect(page).to have_content("Social")
  end
end
