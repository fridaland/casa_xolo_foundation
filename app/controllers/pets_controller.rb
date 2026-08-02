class PetsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @pets = Pet.where(default_filters.merge(filter_params.to_h.compact_blank))
  end

  def show
    @pet = Pet.find(params[:id])
  end

  private

  def default_filters
    {status: [:available, :urgent]}
  end

  def filter_params
    params.permit(:species, :status)
  end
end
