require "rails_helper"

RSpec.describe NewsletterSubscription, type: :model do
  describe "validations" do
    subject { build(:newsletter_subscription) }

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_length_of(:email).is_at_most(255) }
    it { should allow_value("hello@example.com").for(:email) }
    it { should allow_value("user+tag@sub.domain.org").for(:email) }
    it { should_not allow_value("not-an-email").for(:email) }
    it { should_not allow_value("missing@tld").for(:email) }
    it { should_not allow_value("@nodomain.com").for(:email) }
  end

  describe "email normalization" do
    it "downcases the email before validation" do
      sub = create(:newsletter_subscription, email: "HELLO@EXAMPLE.COM")
      expect(sub.reload.email).to eq("hello@example.com")
    end

    it "strips leading and trailing whitespace before validation" do
      sub = create(:newsletter_subscription, email: "  hello@example.com  ")
      expect(sub.reload.email).to eq("hello@example.com")
    end

    it "treats a whitespace-padded email as a duplicate of the normalized form" do
      create(:newsletter_subscription, email: "hello@example.com")
      sub = build(:newsletter_subscription, email: "  hello@example.com  ")
      expect(sub).not_to be_valid
    end
  end
end
