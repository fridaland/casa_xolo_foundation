module Admin
  class VolunteerApplicationsController < Admin::ApplicationController
    def new
      redirect_to admin_volunteer_applications_path,
        alert: "Volunteer applications can only be submitted through the public volunteer form."
    end

    def create
      redirect_to admin_volunteer_applications_path,
        alert: "Volunteer applications can only be submitted through the public volunteer form."
    end

    private

    def authorized_action?(resource, action_name)
      return false if %i[new create].include?(action_name.to_sym)
      super
    end
  end
end
