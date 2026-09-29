class NewsletterSubscriptionsController < ApplicationController
  skip_before_action :authenticate_user!
  rate_limit to: 5, within: 1.minute, by: -> { request.remote_ip }, only: :create

  def create
    subscription = NewsletterSubscription.new(email: params[:email])

    if subscription.save
      redirect_to events_path, notice: "Thanks for subscribing!"
    else
      redirect_to events_path, alert: subscription.errors.full_messages.first
    end
  rescue ActiveRecord::RecordNotUnique
    redirect_to events_path, alert: "Email has already been taken."
  end
end
