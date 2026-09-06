class AdoptionApplication < ApplicationRecord
  belongs_to :pet

  HOUSING_TYPES = ["House", "Apartment", "Condo", "Townhouse", "Mobile Home", "Other"].freeze
  OWNERSHIP_OPTIONS = ["Own", "Rent"].freeze
  YARD_OPTIONS = ["Yes — fenced", "Yes — unfenced", "No"].freeze
  YES_NO_OPTIONS = ["Yes", "No"].freeze

  PHONE_REGEXP = /\A(\+?1[\s.-]?)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}\z/
  EMAIL_REGEXP = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :first_name, :last_name, :email, :phone,
    :street_address, :city, :state, :zip_code,
    :housing_type, :owns_or_rents, :has_yard,
    :has_other_pets, :has_children,
    :pet_experience, :adoption_reason,
    presence: true
  validates :email, format: {with: EMAIL_REGEXP}
  validates :phone, format: {with: PHONE_REGEXP}, allow_blank: true
  validates :housing_type, inclusion: {in: HOUSING_TYPES}, allow_blank: true
  validates :owns_or_rents, inclusion: {in: OWNERSHIP_OPTIONS}, allow_blank: true
  validates :has_yard, inclusion: {in: YARD_OPTIONS}, allow_blank: true
  validates :has_other_pets, inclusion: {in: YES_NO_OPTIONS}, allow_blank: true
  validates :has_children, inclusion: {in: YES_NO_OPTIONS}, allow_blank: true

  before_create { self.submitted_at = Time.current }

  scope :by_status_priority, -> {
    order(
      Arel.sql("CASE status WHEN 'pending' THEN 0 WHEN 'reviewing' THEN 1 WHEN 'approved' THEN 2 ELSE 3 END"),
      submitted_at: :desc
    )
  }
end
