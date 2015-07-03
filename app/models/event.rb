class Event < Base
  belongs_to :creator, class_name: "User", foreign_key: :created_by_user_id
  belongs_to :organization
  belongs_to :pod

  has_one :community_offer_detail # 0 or 1, actually.
  accepts_nested_attributes_for :community_offer_detail

  attribute :address, Address::Type.new, default: Address.new

  def self.available_for_organization(org, pagination)
    return none unless Actual(org)

    where(organization_id: org.id).paginate(pagination).where("ends_at > :now", now: Time.now).where(status: 'approved').order(:starts_at).paginate(pagination)
  end

  def self.available_for_pod(pod, pagination)
    return none unless Actual(pod)

    self.where("organization_id = :org_id OR pod_id = :pod_id", org_id: pod.hub.id, pod_id: pod.id).where("ends_at > :now", now: Time.now).where(status: 'approved').order(:starts_at).paginate(pagination)
  end

  def self.invited_or_attending(user)
    # TODO: Complete this method, add actual logic to limit events to
    # just those the given user has been invited to or is attending.
    all
  end
end
