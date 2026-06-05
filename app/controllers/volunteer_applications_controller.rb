class VolunteerApplicationsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @volunteer_application = VolunteerApplication.new
  end

  def create
    @volunteer_application = VolunteerApplication.new(volunteer_application_params)
    if @volunteer_application.save
      redirect_to thank_you_volunteer_applications_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def thank_you
  end

  private

  def volunteer_application_params
    params.require(:volunteer_application).permit(:name, :email, :phone, :message, :position, :resume)
  end
end
