class ApproveAdoptionApplication
  def initialize(application)
    @application = application
  end

  def call
    @application.with_lock do
      return if @application.status == "approved"

      @application.update!(status: "approved")
      parent = find_or_create_parent
      find_or_create_placement(parent)
    end
  end

  private

  def find_or_create_parent
    Parent.find_or_create_by!(primary_contact_email: @application.email) do |p|
      p.family_name = full_name
      p.primary_contact_name = full_name
    end
  end

  def find_or_create_placement(parent)
    Placement.find_or_create_by!(
      parent: parent,
      pet: @application.pet,
      placement_type: placement_type
    ) do |pl|
      pl.status = :active
      pl.start_date = Date.current
    end
  end

  def full_name
    "#{@application.first_name} #{@application.last_name}"
  end

  def placement_type
    (@application.application_type == "foster") ? :foster : :adoptive
  end
end
