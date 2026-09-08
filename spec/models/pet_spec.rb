require "rails_helper"

RSpec.describe Pet, type: :model do
  describe "fosterable" do
    it "defaults to false" do
      pet = build(:pet)
      expect(pet.fosterable).to be false
    end

    it "can be set to true" do
      pet = build(:pet, :fosterable)
      expect(pet.fosterable).to be true
    end

    describe ".fosterable" do
      it "returns only fosterable pets" do
        fosterable = create(:pet, :fosterable)
        non_fosterable = create(:pet)

        expect(Pet.fosterable).to include(fosterable)
        expect(Pet.fosterable).not_to include(non_fosterable)
      end
    end
  end

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
