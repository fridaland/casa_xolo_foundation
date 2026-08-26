module Admin
  class AdoptionApplicationsController < Admin::ApplicationController
    def scoped_resource
      super.order(
        Arel.sql("CASE status WHEN 'pending' THEN 0 WHEN 'reviewing' THEN 1 WHEN 'approved' THEN 2 ELSE 3 END"),
        submitted_at: :desc
      )
    end
  end
end
