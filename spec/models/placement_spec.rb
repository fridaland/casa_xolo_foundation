require "rails_helper"

RSpec.describe Placement, type: :model do
  describe "validations" do
    it { should validate_presence_of(:start_date) }

    it {
      should define_enum_for(:placement_type)
        .with_values(foster: 0, adoptive: 1)
        .validating
    }

    it {
      should define_enum_for(:status)
        .with_values(active: 0, completed: 1)
        .validating
    }
  end

  describe "associations" do
    it { should belong_to(:parent) }
    it { should belong_to(:pet) }
  end

  describe "#pet_placement_status" do
    it "returns 'In Foster Care' for foster placements" do
      placement = build(:placement, placement_type: :foster)
      expect(placement.pet_placement_status).to eq("In Foster Care")
    end

    it "returns 'Adopted' for adoptive placements" do
      placement = build(:placement, placement_type: :adoptive)
      expect(placement.pet_placement_status).to eq("Adopted")
    end

    it "returns nil when placement_type is nil" do
      placement = build(:placement)
      placement.placement_type = nil
      expect(placement.pet_placement_status).to be_nil
    end
  end
end
