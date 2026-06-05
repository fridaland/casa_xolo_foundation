class VolunteerApplication < ApplicationRecord
  has_one_attached :resume

  STATUSES = %w[pending reviewing accepted declined].freeze
  POSITIONS = [
    "Animal Care",
    "Event Support",
    "Marketing & Social Media",
    "Facility Maintenance",
    "All of the above, where needed"
  ].freeze

  validates :name, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  before_create { self.submitted_at = Time.current }
end
