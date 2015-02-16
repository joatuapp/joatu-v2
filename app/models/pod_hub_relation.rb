class PodHubRelation < PodOrganizationRelation
  belongs_to :pod
  belongs_to :organization
end
