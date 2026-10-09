require "administrate/base_dashboard"

class ParentDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    family_name: Field::String,
    primary_contact_name: Field::String,
    primary_contact_email: Field::String,
    placements: Field::HasMany,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    family_name
    primary_contact_name
    primary_contact_email
    placements
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    family_name
    primary_contact_name
    primary_contact_email
    placements
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    family_name
    primary_contact_name
    primary_contact_email
  ].freeze

  COLLECTION_FILTERS = {}.freeze

  def display_resource(parent)
    parent.family_name.presence || "Parent ##{parent.id}"
  end
end
