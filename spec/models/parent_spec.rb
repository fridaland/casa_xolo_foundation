require "rails_helper"

RSpec.describe Parent, type: :model do
  describe "validations" do
    it "is valid with required attributes" do
      parent = build(:parent)
      expect(parent).to be_valid
    end

    it "is invalid without a family_name" do
      parent = build(:parent, family_name: nil)
      expect(parent).not_to be_valid
      expect(parent.errors[:family_name]).to be_present
    end

    it "is invalid without a parent_type" do
      parent = build(:parent, parent_type: nil)
      expect(parent).not_to be_valid
    end

    it "is invalid without a status" do
      parent = build(:parent, status: nil)
      expect(parent).not_to be_valid
    end
  end

  describe "enums" do
    it "has foster and adoptive parent types" do
      expect(Parent.parent_types).to eq("foster" => 0, "adoptive" => 1)
    end

    it "has active and completed statuses" do
      expect(Parent.statuses).to eq("active" => 0, "completed" => 1)
    end
  end

  describe "associations" do
    it "belongs to an optional pet" do
      parent = build(:parent, pet: nil)
      expect(parent).to be_valid
    end

    it "can be associated with a pet" do
      pet = create(:pet)
      parent = create(:parent, pet: pet)
      expect(parent.pet).to eq(pet)
    end
  end

  describe "#pet_placement_status" do
    it "returns 'In Foster Care' for foster parents" do
      parent = build(:parent, parent_type: :foster)
      expect(parent.pet_placement_status).to eq("In Foster Care")
    end

    it "returns 'Adopted' for adoptive parents" do
      parent = build(:parent, parent_type: :adoptive)
      expect(parent.pet_placement_status).to eq("Adopted")
    end
  end
end
