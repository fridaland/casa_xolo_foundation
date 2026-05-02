require "administrate/base_dashboard"

class EventDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    name: Field::String,
    event_date: Field::DateTime,
    location: Field::String,
    description: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    id
    name
    event_date
    location
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    name
    event_date
    location
    description
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    name
    event_date
    location
    description
  ].freeze

  COLLECTION_FILTERS = {
    upcoming: ->(resources) { resources.upcoming }
  }.freeze

  def display_resource(event)
    event.name
  end
end
