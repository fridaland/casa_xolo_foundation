require "rails_helper"

RSpec.describe "Newsletter subscriptions", type: :system do
  before { driven_by(:rack_test) }

  it "subscribes with a valid email" do
    visit events_path

    fill_in "Enter your email", with: "hello@example.com"
    click_button "Subscribe"

    expect(page).to have_content("Thanks for subscribing!")
    expect(NewsletterSubscription.count).to eq(1)
  end

  it "shows an error for an invalid email" do
    visit events_path

    fill_in "Enter your email", with: "not-an-email"
    click_button "Subscribe"

    expect(page).to have_content("Email is invalid")
    expect(NewsletterSubscription.count).to eq(0)
  end

  it "shows an error for a duplicate email" do
    create(:newsletter_subscription, email: "already@example.com")

    visit events_path

    fill_in "Enter your email", with: "already@example.com"
    click_button "Subscribe"

    expect(page).to have_content("Email has already been taken")
    expect(NewsletterSubscription.count).to eq(1)
  end

  it "is case-insensitive for duplicate detection" do
    create(:newsletter_subscription, email: "hello@example.com")

    visit events_path

    fill_in "Enter your email", with: "HELLO@EXAMPLE.COM"
    click_button "Subscribe"

    expect(page).to have_content("Email has already been taken")
  end
end
