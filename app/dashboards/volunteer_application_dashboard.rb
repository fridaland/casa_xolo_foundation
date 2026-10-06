require "administrate/base_dashboard"

class VolunteerApplicationDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    name: Field::String,
    email: Field::String,
    phone: Field::String,
    position: Field::Select.with_options(
      collection: VolunteerApplication::POSITIONS,
      include_blank: true,
    ),
    message: Field::Text,
    status: Field::Select.with_options(
      collection: VolunteerApplication::STATUSES,
      include_blank: false,
    ),
    resume: Field::ActiveStorage.with_options(show_display_preview: false, index_display_preview: false),
    submitted_at: Field::DateTime.with_options(format: "%b %-d, %Y %-l:%M %p %Z", timezone: "Central Time (US & Canada)"),
    created_at: Field::DateTime.with_options(format: "%b %-d, %Y %-l:%M %p %Z", timezone: "Central Time (US & Canada)"),
    updated_at: Field::DateTime.with_options(format: "%b %-d, %Y %-l:%M %p %Z", timezone: "Central Time (US & Canada)")
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    id
    name
    email
    position
    status
    submitted_at
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    name
    email
    phone
    position
    message
    status
    resume
    submitted_at
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    status
  ].freeze

  COLLECTION_FILTERS = {
    pending: ->(resources) { resources.where(status: "pending") },
    reviewing: ->(resources) { resources.where(status: "reviewing") },
    accepted: ->(resources) { resources.where(status: "accepted") },
    declined: ->(resources) { resources.where(status: "declined") }
  }.freeze

  def display_resource(volunteer_application)
    volunteer_application.name
  end
end
