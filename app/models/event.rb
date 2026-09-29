class Event < ApplicationRecord
  URL_REGEX = %r{\Ahttps?://.+\z}i

  validates :name, presence: true
  validates :event_date, presence: true
  validates :signup_url,
            format: { with: URL_REGEX, message: "must be a valid URL starting with http or https" },
            allow_blank: true

  scope :upcoming, -> { where(event_date: Time.current..).order(:event_date) }
end
