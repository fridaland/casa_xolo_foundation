class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @pets = Pet.where(status: :available).limit(4)
  end
end
