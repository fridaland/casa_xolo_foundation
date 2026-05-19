class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def volunteer
  end

  def about
  end
end
