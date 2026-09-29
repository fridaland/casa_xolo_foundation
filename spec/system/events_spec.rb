require "rails_helper"

RSpec.describe "Events page", type: :system do
  before { driven_by(:rack_test) }

  describe "events listing" do
    it "shows upcoming events with name, date, and location" do
      event_date = 2.weeks.from_now
      create(:event,
             name: "Community Adoption Day",
             location: "Casa Xolo HQ",
             event_date: event_date,)

      visit events_path

      expect(page).to have_content("Community Adoption Day")
      expect(page).to have_content(event_date.strftime("%B %-d, %Y"))
      expect(page).to have_content("Casa Xolo HQ")
    end

    it "does not show past events" do
      create(:event, name: "Old Gala", event_date: 1.day.ago)

      visit events_path

      expect(page).not_to have_content("Old Gala")
    end

    it "shows events ordered by date ascending" do
      create(:event, name: "Later Event", event_date: 3.weeks.from_now)
      create(:event, name: "Sooner Event", event_date: 1.week.from_now)

      visit events_path

      expect(page.body.index("Sooner Event")).to be < page.body.index("Later Event")
    end

    it "shows an empty state when there are no upcoming events" do
      visit events_path

      expect(page).to have_content("No upcoming events")
    end
  end

  describe "sign up link" do
    it "shows a Sign Up button when the event has a signup_url" do
      create(:event, :with_signup_url, name: "Gala Night", signup_url: "https://example.com/gala")

      visit events_path

      expect(page).to have_link("Sign Up", href: "https://example.com/gala")
    end

    it "does not show a Sign Up button when signup_url is absent" do
      create(:event, name: "Open House", signup_url: nil)

      visit events_path

      expect(page).not_to have_link("Sign Up")
    end
  end

  describe "newsletter form" do
    it "shows the newsletter signup form" do
      visit events_path

      expect(page).to have_field("Enter your email")
      expect(page).to have_button("Subscribe")
    end
  end
end
