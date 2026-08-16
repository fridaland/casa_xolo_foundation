class AdoptionApplicationsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_pet

  def new
    @adoption_application = AdoptionApplication.new
  end

  def create
    @adoption_application = AdoptionApplication.new(adoption_application_params)
    @adoption_application.pet = @pet
    if @adoption_application.save
      redirect_to thank_you_pet_adoption_applications_path(@pet)
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

  def adoption_application_params
    params.require(:adoption_application).permit(
      :first_name, :last_name, :email, :phone,
      :street_address, :city, :state, :zip_code,
      :housing_type, :owns_or_rents, :has_yard,
      :has_other_pets, :has_children,
      :pet_experience, :adoption_reason, :references
    )
  end
end
