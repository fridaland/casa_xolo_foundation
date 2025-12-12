class Pet < ApplicationRecord
  has_many_attached :photos

  TEMPERAMENT_OPTIONS = [
    "calm",
    "energetic",
    "good_with_cats",
    "good_with_dogs",
    "good_with_kids",
    "good_with_seniors",
    "independent",
    "social",
    "reactive",
    "shy"
  ].freeze

  validates :name, presence: true
  validates :sex, presence: true
  validates :color, presence: true
  validates :description, presence: true

  enum :size, ["small", "medium", "large"]
  enum :species, ["dog", "cat", "other"]
  enum :status, ["available", "adopted", "urgent"]
  enum :sex, ["female", "male"]
end
