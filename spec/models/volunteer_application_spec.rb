require "rails_helper"

RSpec.describe VolunteerApplication, type: :model do
  subject { build(:volunteer_application) }

  describe "validations" do
    # Presence
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:phone) }
    it { should validate_presence_of(:position) }
    it { should validate_presence_of(:message) }

    # Email format
    it { should allow_value("user@example.com").for(:email) }
    it { should allow_value("user+tag@sub.domain.org").for(:email) }
    it { should_not allow_value("not-an-email").for(:email) }
    it { should_not allow_value("basdsl@jnlds").for(:email) }
    it { should_not allow_value("missing@").for(:email) }
    it { should_not allow_value("@nodomain.com").for(:email) }

    # Phone format
    it { should allow_value("555-867-5309").for(:phone) }
    it { should allow_value("(555) 867-5309").for(:phone) }
    it { should allow_value("5558675309").for(:phone) }
    it { should allow_value("+1 555 867 5309").for(:phone) }
    it { should allow_value("555.867.5309").for(:phone) }
    it { should_not allow_value("12233").for(:phone) }
    it { should_not allow_value("abcdefghij").for(:phone) }
    it { should_not allow_value("123").for(:phone) }

    # Position must be one of the defined options
    it { should validate_inclusion_of(:position).in_array(VolunteerApplication::POSITIONS) }
  end
end
