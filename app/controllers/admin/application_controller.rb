module Admin
  class ApplicationController < Administrate::ApplicationController
    before_action :authenticate_user!
  end
end
