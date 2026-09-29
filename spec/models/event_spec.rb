require "rails_helper"

RSpec.describe Event, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:event_date) }
  end

  describe "signup_url" do
    it "is optional — nil is valid" do
      event = build(:event, signup_url: nil)
      expect(event).to be_valid
    end

    it "is optional — blank string is valid" do
      event = build(:event, signup_url: "")
      expect(event).to be_valid
    end

    it "accepts a valid https URL" do
      event = build(:event, signup_url: "https://example.com/signup")
      expect(event).to be_valid
    end

    it "accepts a valid http URL" do
      event = build(:event, signup_url: "http://example.com/signup")
      expect(event).to be_valid
    end

    it "rejects a URL without a scheme" do
      event = build(:event, signup_url: "example.com/signup")
      expect(event).not_to be_valid
      expect(event.errors[:signup_url]).to be_present
    end

    it "rejects an arbitrary non-URL string" do
      event = build(:event, signup_url: "not a url")
      expect(event).not_to be_valid
    end
  end

  describe ".upcoming" do
    it "returns events ordered by date ascending" do
      later  = create(:event, event_date: 3.weeks.from_now)
      sooner = create(:event, event_date: 1.week.from_now)

      expect(Event.upcoming).to eq([sooner, later])
    end

    it "excludes past events" do
      past   = create(:event, event_date: 1.day.ago)
      future = create(:event, event_date: 1.week.from_now)

      expect(Event.upcoming).to include(future)
      expect(Event.upcoming).not_to include(past)
    end
  end
end
