require "rails_helper"

RSpec.describe "NewsletterSubscriptions", type: :request do
  describe "POST /newsletter_subscriptions" do
    it "creates a subscription and redirects with notice" do
      post newsletter_subscriptions_path, params: { email: "test@example.com" }

      expect(response).to redirect_to(events_path)
      expect(flash[:notice]).to eq("Thanks for subscribing!")
      expect(NewsletterSubscription.count).to eq(1)
    end

    it "redirects with alert on invalid email" do
      post newsletter_subscriptions_path, params: { email: "bad" }

      expect(response).to redirect_to(events_path)
      expect(flash[:alert]).to be_present
      expect(NewsletterSubscription.count).to eq(0)
    end

    it "redirects with alert on blank email" do
      post newsletter_subscriptions_path, params: { email: "" }

      expect(response).to redirect_to(events_path)
      expect(flash[:alert]).to be_present
    end

    it "handles a DB-level duplicate gracefully (race condition)" do
      create(:newsletter_subscription, email: "taken@example.com")

      # Simulate the race condition: bypass model validations so the
      # uniqueness check passes but the INSERT hits the unique index.
      allow_any_instance_of(NewsletterSubscription).to receive(:valid?).and_return(true)
      allow_any_instance_of(NewsletterSubscription).to receive(:save) do |_record|
        raise ActiveRecord::RecordNotUnique
      end

      post newsletter_subscriptions_path, params: { email: "taken@example.com" }

      expect(response).to redirect_to(events_path)
      expect(flash[:alert]).to be_present
    end
  end
end
