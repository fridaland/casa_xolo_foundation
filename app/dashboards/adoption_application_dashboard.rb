require "administrate/base_dashboard"

class AdoptionApplicationDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    pet: Field::BelongsTo,
    first_name: Field::String,
    last_name: Field::String,
    email: Field::String,
    phone: Field::String,
    street_address: Field::String,
    city: Field::String,
    state: Field::String,
    zip_code: Field::String,
    housing_type: Field::String,
    owns_or_rents: Field::String,
    has_yard: Field::String,
    has_other_pets: Field::String,
    has_children: Field::String,
    pet_experience: Field::Text,
    adoption_reason: Field::Text,
    references: Field::Text,
    status: Field::Select.with_options(
      collection: %w[pending reviewing approved rejected],
      include_blank: false
    ),
    submitted_at: Field::DateTime,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    pet
    first_name
    last_name
    email
    status
    submitted_at
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    pet
    status
    submitted_at
    first_name
    last_name
    email
    phone
    street_address
    city
    state
    zip_code
    housing_type
    owns_or_rents
    has_yard
    has_other_pets
    has_children
    pet_experience
    adoption_reason
    references
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = [].freeze

  COLLECTION_FILTERS = {
    pending: ->(resources) { resources.where(status: "pending") },
    reviewing: ->(resources) { resources.where(status: "reviewing") },
    approved: ->(resources) { resources.where(status: "approved") },
    rejected: ->(resources) { resources.where(status: "rejected") }
  }.freeze

  def display_resource(adoption_application)
    "#{adoption_application.first_name} #{adoption_application.last_name} — #{adoption_application.pet&.name}"
  end
end
