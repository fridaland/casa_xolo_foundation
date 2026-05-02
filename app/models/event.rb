class Event < ApplicationRecord
  validates :name, presence: true
  validates :event_date, presence: true

  scope :upcoming, -> { where("event_date >= ?", Time.current).order(:event_date) }
end
