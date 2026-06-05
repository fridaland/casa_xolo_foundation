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

  PHONE_REGEXP = /\A(\+?1[\s.-]?)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}\z/
  EMAIL_REGEXP = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, :email, :phone, :position, :message, presence: true
  validates :email, format: {with: EMAIL_REGEXP}
  validates :phone, format: {with: PHONE_REGEXP}, allow_blank: true
  validates :position, inclusion: {in: POSITIONS}, allow_blank: true

  before_create { self.submitted_at = Time.current }
end
