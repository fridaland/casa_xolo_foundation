class PetsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @pets = Pet.where(default_filters.merge(filter_params.to_h.compact_blank))
      .order(Arel.sql("CASE status WHEN 2 THEN 0 WHEN 0 THEN 1 WHEN 3 THEN 2 ELSE 3 END"))
  end

  def show
    @pet = Pet.find(params[:id])
  end

  private

  def default_filters
    {status: [:available, :urgent, :pending]}
  end

  def filter_params
    params.permit(:species, :status)
  end
end
