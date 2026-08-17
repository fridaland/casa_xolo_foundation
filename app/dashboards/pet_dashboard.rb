require "administrate/base_dashboard"

class PetDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    name: Field::String,
    species: Field::Select.with_options(
      collection: Pet.species.keys,
      include_blank: true
    ),
    sex: Field::Select.with_options(
      collection: Pet.sexes.keys,
      include_blank: true
    ),
    color: Field::String,
    description: Field::Text,
    breed: Field::String,
    age: Field::Number,
    size: Field::Select.with_options(
      collection: Pet.sizes.keys,
      include_blank: true
    ),
    status: Field::Select.with_options(
      collection: Pet.statuses.keys,
      include_blank: true
    ),
    spayed_neutered: Field::Boolean,
    temperament: MultiSelectField.with_options(
      collection: Pet::TEMPERAMENT_OPTIONS
    ),
    vaccinated: Field::Boolean,
    microchipped: Field::Boolean,
    weight: Field::Number.with_options(decimals: 2),
    photos: Field::ActiveStorage.with_options(
      show_preview_size: [150, 150],
      destroy_url: proc do |namespace, resource, attachment|
        [:photo_admin_pet, {photo_id: attachment.id}]
      end
    )
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    name
    species
    sex
    color
    description
    status
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    name
    species
    breed
    sex
    color
    description
    size
    temperament
    age
    status
    spayed_neutered
    vaccinated
    microchipped
    photos
    weight
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    name
    species
    breed
    sex
    color
    description
    size
    temperament
    age
    status
    spayed_neutered
    vaccinated
    microchipped
    photos
    weight
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {
    available: ->(resources) { resources.where(status: "available") },
    adopted: ->(resources) { resources.where(status: "adopted") },
    urgent: ->(resources) { resources.where(status: "urgent") },
    pending: ->(resources) { resources.where(status: "pending") },
    cat: ->(resources) { resources.where(species: "cat") },
    dog: ->(resources) { resources.where(species: "dog") }
  }.freeze

  # Overwrite this method to customize how pets are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(pet)
    pet.name
  end

  def permitted_attributes(_action = nil)
    super + [photos: []]
  end
end
