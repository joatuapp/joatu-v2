class EventForm < ApplicationForm
  property :name
  property :description
  property :starts_at, type: DateTime
  property :ends_at, type: DateTime
  property :creator
  property :organization

  property :address

  def creator_id=(val)
    self.creator = User.find(val)
  end

  def organization_id=(val)
    self.organization = Organization.find(val)
  end
end
