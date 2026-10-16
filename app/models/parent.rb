class Parent < ApplicationRecord
  has_many :placements, dependent: :destroy
  has_many :pets, through: :placements

  validates :family_name, presence: true

  def to_s
    family_name
  end
end
