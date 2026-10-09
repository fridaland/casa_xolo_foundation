require "rails_helper"

RSpec.describe Parent, type: :model do
  describe "validations" do
    it { should validate_presence_of(:family_name) }
  end

  describe "associations" do
    it { should have_many(:placements).dependent(:destroy) }
    it { should have_many(:pets).through(:placements) }

    it "destroys associated placements when destroyed" do
      parent = create(:parent)
      create(:placement, parent: parent)
      expect { parent.destroy }.to change(Placement, :count).by(-1)
    end
  end
end
