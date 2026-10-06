class Parent < ApplicationRecord
  belongs_to :pet, optional: true

  enum :parent_type, { foster: 0, adoptive: 1 }, validate: true
  enum :status, { active: 0, completed: 1 }, validate: true

  validates :family_name, presence: true
  validates :parent_type, presence: true
  validates :status, presence: true

  def pet_placement_status
    foster? ? "In Foster Care" : "Adopted"
  end
end
