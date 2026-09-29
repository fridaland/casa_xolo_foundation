class NewsletterSubscription < ApplicationRecord
  EMAIL_REGEX = /\A[^@\s]+@[^@\s]+\.[^@\s]+\z/

  before_validation :normalize_email

  validates :email,
            presence: true,
            length: { maximum: 255 },
            format: { with: EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  private

  def normalize_email
    self.email = email&.downcase&.strip
  end
end
