module Admin
  class AdoptionApplicationsController < Admin::ApplicationController
    def scoped_resource
      super.by_status_priority
    end
  end
end
