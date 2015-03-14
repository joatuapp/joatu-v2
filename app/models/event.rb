class Event < Base
  belongs_to :creator, class: User, foreign_key: :created_by_user_id
  belongs_to :organization
  belongs_to :pod

  composed_of :address, mapping: %w(address_json to_json)

  def self.available_for_organization(org, pagination)
    return none unless Actual(org)

    where(organization_id: org.id).paginate(pagination)
  end

  def self.available_for_pod(pod, pagination)
    return none unless Actual(pod)

    self.where("organization_id = :org_id OR pod_id = :pod_id", org_id: pod.hub.id, pod_id: pod.id).where("ends_at > :now", now: Time.now).order(:starts_at).paginate(pagination)
  end
end
