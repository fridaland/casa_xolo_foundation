require "administrate/base_dashboard"

class ParentDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    family_name: Field::String,
    primary_contact_name: Field::String,
    primary_contact_email: Field::String,
    parent_type: BadgeField.with_options(
      collection: Parent.parent_types.keys,
      colors: {
        "foster"   => "badge--parent-foster",
        "adoptive" => "badge--parent-adoptive",
      },
    ),
    pet: Field::BelongsTo,
    pet_placement_status: BadgeField.with_options(
      colors: {
        "In Foster Care" => "badge--pet-foster",
        "Adopted"        => "badge--pet-adopted",
      },
    ),
    status: BadgeField.with_options(
      collection: Parent.statuses.keys,
      colors: {
        "active"    => "badge--status-active",
        "completed" => "badge--status-completed",
      },
    ),
    start_date: Field::Date,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    family_name
    primary_contact_name
    parent_type
    pet
    pet_placement_status
    status
    start_date
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    family_name
    primary_contact_name
    primary_contact_email
    parent_type
    pet
    pet_placement_status
    status
    start_date
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    family_name
    primary_contact_name
    primary_contact_email
    parent_type
    pet
    status
    start_date
  ].freeze

  COLLECTION_FILTERS = {}.freeze

  def display_resource(parent)
    parent.family_name.presence || "Parent ##{parent.id}"
  end
end
