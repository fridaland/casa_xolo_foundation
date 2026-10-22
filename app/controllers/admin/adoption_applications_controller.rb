module Admin
  class AdoptionApplicationsController < Admin::ApplicationController
    def scoped_resource
      super.by_status_priority
    end

    def approve
      ApproveAdoptionApplication.new(requested_resource).call
      redirect_to(
        [namespace, requested_resource],
        notice: t("administrate.controller.update.success", resource: resource_name)
      )
    end
  end
end
