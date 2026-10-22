require "rails_helper"

RSpec.describe ApproveAdoptionApplication do
  subject(:service) { described_class.new(application) }

  let(:pet) { create(:pet) }
  let(:application) { create(:adoption_application, :foster, pet: pet) }

  describe "#call" do
    it "marks the application as approved" do
      service.call
      expect(application.reload.status).to eq("approved")
    end

    it "creates a parent record from the applicant's info" do
      expect { service.call }.to change(Parent, :count).by(1)

      parent = Parent.last
      expect(parent.family_name).to eq("#{application.first_name} #{application.last_name}")
      expect(parent.primary_contact_name).to eq("#{application.first_name} #{application.last_name}")
      expect(parent.primary_contact_email).to eq(application.email)
    end

    it "creates a placement linking the parent to the pet" do
      expect { service.call }.to change(Placement, :count).by(1)

      placement = Placement.last
      expect(placement.pet).to eq(pet)
      expect(placement.parent.primary_contact_email).to eq(application.email)
      expect(placement.status).to eq("active")
      expect(placement.start_date).to eq(Date.current)
    end

    it "sets placement_type to foster for foster applications" do
      application = create(:adoption_application, :foster, pet: pet)
      described_class.new(application).call
      expect(Placement.last.placement_type).to eq("foster")
    end

    it "sets placement_type to adoptive for adoption applications" do
      application = create(:adoption_application, :adoption, pet: pet)
      described_class.new(application).call
      expect(Placement.last.placement_type).to eq("adoptive")
    end

    context "when the application is already approved" do
      before { application.update!(status: "approved") }

      it "returns early without creating records" do
        expect { service.call }.not_to change(Parent, :count)
      end

      it "does not issue a redundant update" do
        expect(application).not_to receive(:update!)
        service.call
      end
    end

    context "when the application is approved a second time" do
      before { service.call }

      it "does not create a duplicate parent" do
        expect { service.call }.not_to change(Parent, :count)
      end

      it "does not create a duplicate placement" do
        expect { service.call }.not_to change(Placement, :count)
      end

      it "still marks the application as approved" do
        application.update!(status: "reviewing")
        service.call
        expect(application.reload.status).to eq("approved")
      end
    end

    context "when a parent record already exists for this email" do
      before { create(:parent, primary_contact_email: application.email) }

      it "reuses the existing parent" do
        expect { service.call }.not_to change(Parent, :count)
      end

      it "still creates a placement for the existing parent" do
        expect { service.call }.to change(Placement, :count).by(1)
      end
    end

    context "when placement creation fails" do
      before do
        allow(Placement).to receive(:find_or_create_by!).and_raise(ActiveRecord::RecordInvalid)
      end

      it "rolls back the application status change" do
        expect { service.call }.to raise_error(ActiveRecord::RecordInvalid)
        expect(application.reload.status).not_to eq("approved")
      end

      it "rolls back any parent creation" do
        expect { service.call }.to raise_error(ActiveRecord::RecordInvalid)
        expect(Parent.count).to eq(0)
      end
    end
  end
end
