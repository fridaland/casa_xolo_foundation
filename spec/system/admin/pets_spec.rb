require "rails_helper"

RSpec.describe "Admin::Pets", type: :system do
  before do
    driven_by(:rack_test) # fast, no JS; switch to :selenium if you need JS
  end

  it "allows creating a pet with multiple temperaments" do
    user = create(:user)
    login_as user
    visit "/admin/pets"
    expect(page).to have_content("New pet")
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

    # Going back to the index and then navigating to the page ensures
    # We are loading the values from the database
    visit "/admin/pets"

    click_on "Tater Tot"
    expect(page).to have_content("Calm")
    expect(page).to have_content("Good with kids")
    expect(page).to have_content("Social")
    expect(page).to have_content("male")
    expect(page).to have_content("medium")
    expect(page).to have_content("dog")
    expect(page).to have_content("available")
  end

  it "allows creating a pet with attached photos" do
    visit "/admin/pets"

    click_on "New pet"

    fill_in "Name", with: "Salem"
    select "cat", from: "Species"
    select "female", from: "Sex"
    fill_in "Color", with: "Black"
    fill_in "Description", with: "A lovely black cat looking for a home."

    attach_file "Photos", [
      Rails.root.join("spec/fixtures/files/cat_salem.jpg")
    ]

    click_on "Create Pet"

    expect(page).to have_content("Salem")

    click_on "Salem"
    expect(page).to have_selector("img[src*='cat_salem.jpg']")
  end
end
