require "administrate/field/base"

class BadgeField < Administrate::Field::Base
  def to_s
    data.to_s.titleize
  end

  def badge_css_class
    colors = options.fetch(:colors, {})
    colors.fetch(data&.to_s, "badge--default")
  end

  def self.searchable?
    false
  end
end
