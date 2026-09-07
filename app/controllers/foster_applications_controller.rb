class FosterApplicationsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_pet

  def new
    @application = AdoptionApplication.new(application_type: "foster")
  end

  def create
    @application = AdoptionApplication.new(foster_application_params)
    @application.pet = @pet
    @application.application_type = "foster"
    if @application.save
      redirect_to thank_you_pet_foster_applications_path(@pet)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def thank_you
  end

  private

  def set_pet
    @pet = Pet.find(params[:pet_id])
  end

  def foster_application_params
    params.require(:adoption_application)
      .permit(
        :first_name,
        :last_name,
        :email,
        :phone,
        :street_address,
        :city,
        :state,
        :zip_code,
        :housing_type,
        :owns_or_rents,
        :has_yard,
        :has_other_pets,
        :has_children,
        :pet_experience,
        :adoption_reason,
        :references
      )
  end
end
