module Admin
  class ApplicationController < Administrate::ApplicationController
    before_action :authenticate_user!

    private

    # Administrate uses params.require(resource_key) which raises
    # ActionController::ParameterMissing when FORM_ATTRIBUTES is empty
    # (no form fields means the resource key is absent from params).
    # fetch with a default lets empty forms still save successfully.
    def resource_params
      params
        .fetch(resource_class.model_name.param_key, ActionController::Parameters.new)
        .permit(dashboard.permitted_attributes(action_name))
    end
  end
end
