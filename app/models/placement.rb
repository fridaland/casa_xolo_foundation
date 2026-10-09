class Placement < ApplicationRecord
  belongs_to :parent
  belongs_to :pet

  enum :placement_type, { foster: 0, adoptive: 1 }, validate: true
  enum :status, { active: 0, completed: 1 }, validate: true

  validates :placement_type, presence: true
  validates :status, presence: true
  validates :start_date, presence: true

  def pet_placement_status
    return nil if placement_type.nil?
    foster? ? "In Foster Care" : "Adopted"
  end
end
