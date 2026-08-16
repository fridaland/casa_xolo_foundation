require "rails_helper"

RSpec.describe AdoptionApplication, type: :model do
  describe "associations" do
    it { should belong_to(:pet) }
  end

  describe "validations" do
    subject { build(:adoption_application) }

    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:phone) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip_code) }
    it { should validate_presence_of(:housing_type) }
    it { should validate_presence_of(:owns_or_rents) }
    it { should validate_presence_of(:has_yard) }
    it { should validate_presence_of(:has_other_pets) }
    it { should validate_presence_of(:has_children) }
    it { should validate_presence_of(:pet_experience) }
    it { should validate_presence_of(:adoption_reason) }

    it {
      should validate_inclusion_of(:housing_type)
        .in_array(AdoptionApplication::HOUSING_TYPES)
    }
    it {
      should validate_inclusion_of(:owns_or_rents)
        .in_array(AdoptionApplication::OWNERSHIP_OPTIONS)
    }
    it {
      should validate_inclusion_of(:has_yard)
        .in_array(AdoptionApplication::YARD_OPTIONS)
    }
    it {
      should validate_inclusion_of(:has_other_pets)
        .in_array(AdoptionApplication::YES_NO_OPTIONS)
    }
    it {
      should validate_inclusion_of(:has_children)
        .in_array(AdoptionApplication::YES_NO_OPTIONS)
    }
  end

  describe "callbacks" do
    it "sets submitted_at on create" do
      app = create(:adoption_application)
      expect(app.submitted_at).to be_present
    end
  end
end
