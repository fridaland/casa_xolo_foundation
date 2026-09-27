class Pet < ApplicationRecord
  has_many_attached :photos

  TEMPERAMENT_OPTIONS = %w[
    calm
    energetic
    good_with_cats
    good_with_dogs
    good_with_kids
    good_with_seniors
    independent
    social
    reactive
    shy
  ].freeze

  validates :name, presence: true
  validates :color, presence: true
  validates :description, presence: true

  scope :fosterable, -> { where(fosterable: true) }

  enum :size, { "small" => 0, "medium" => 1, "large" => 2 }, validate: { allow_nil: true }
  enum :species, { "dog" => 0, "cat" => 1, "other" => 2 }, validate: { allow_nil: true }
  enum :status, { "available" => 0, "adopted" => 1, "urgent" => 2, "pending" => 3 }, validate: { allow_nil: true }
  enum :sex, { "female" => 0, "male" => 1 }, validate: true
end
