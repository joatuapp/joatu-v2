class Pod < ActiveRecord::Base
  has_one :hub, through: :hub_organization_relation, source: :organization
  has_one :hub_organization_relation, class: PodHubRelation

  # NOTE: The custom select DISTINCT ON query is required because the ideal way
  # of doing this (simply using AR's "uniq" method does a plain "DISTINCT",
  # which fails on postgres 9.3 for tables with JSON columns (which user does).
  # Once Amazon RDS updates to postgres 9.4 and we can convert to JSONb columns
  # we should no longer have this problem, and should revert the scope to this:
  # -> { uniq }
  #
  has_many :members, -> { select("DISTINCT ON (users.id) users.*") }, class: User, through: :pod_memberships, source: :user
  has_many :pod_memberships

  def focus_area_geojson
    return "" if self.new_record?

    sql = "SELECT ST_asgeojson(focus_area) FROM #{self.class.table_name} where id = #{self.id}"
    cursor = self.class.connection.execute(sql)
    cursor.first["st_asgeojson"]
  end
end
