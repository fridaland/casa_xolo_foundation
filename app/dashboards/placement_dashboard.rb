require "administrate/base_dashboard"

class PlacementDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    parent: Field::BelongsTo,
    pet: Field::BelongsTo,
    placement_type: BadgeField.with_options(
      collection: Placement.placement_types.keys,
      colors: {
        "foster" => "badge--parent-foster",
        "adoptive" => "badge--parent-adoptive"
      },
    ),
    pet_placement_status: BadgeField.with_options(
      colors: {
        "In Foster Care" => "badge--pet-foster",
        "Adopted" => "badge--pet-adopted"
      },
    ),
    status: BadgeField.with_options(
      collection: Placement.statuses.keys,
      colors: {
        "active" => "badge--status-active",
        "completed" => "badge--status-completed"
      },
    ),
    start_date: Field::Date,
    end_date: Field::Date,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    parent
    pet
    placement_type
    pet_placement_status
    status
    start_date
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    parent
    pet
    placement_type
    pet_placement_status
    status
    start_date
    end_date
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    parent
    pet
    placement_type
    status
    start_date
    end_date
  ].freeze

  COLLECTION_FILTERS = {
    active: ->(resources) { resources.where(status: :active) },
    completed: ->(resources) { resources.where(status: :completed) },
    foster: ->(resources) { resources.where(placement_type: :foster) },
    adoptive: ->(resources) { resources.where(placement_type: :adoptive) }
  }.freeze

  def display_resource(placement)
    "#{placement.parent&.family_name} — #{placement.pet&.name}"
  end
end
