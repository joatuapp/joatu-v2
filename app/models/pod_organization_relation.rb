class PodOrganizationRelation < ActiveRecord::Base
  self.table_name = "pod_organization_relations"

  belongs_to :pod
  belongs_to :organization
end
