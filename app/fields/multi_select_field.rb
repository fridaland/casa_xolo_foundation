require "administrate/field/base"

class MultiSelectField < Administrate::Field::Base
  def to_s
    data&.join(", ")
  end

  def selectable_options
    options.fetch(:collection, [])
  end

  def self.searchable?
    false
  end
end
