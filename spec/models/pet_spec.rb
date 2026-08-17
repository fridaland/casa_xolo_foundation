require "rails_helper"

RSpec.describe Pet, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :color }
    it { should validate_presence_of :description }

    it {
      should define_enum_for(:size)
        .with_values([:small, :medium, :large])
        .validating(allowing_nil: true)
    }
    it {
      should define_enum_for(:species)
        .with_values([:dog, :cat, :other])
        .validating(allowing_nil: true)
    }
    it {
      should define_enum_for(:status)
        .with_values([:available, :adopted, :urgent, :pending])
        .validating(allowing_nil: true)
    }
    it {
      should define_enum_for(:sex)
        .with_values([:female, :male])
        .validating
    }
  end
end
