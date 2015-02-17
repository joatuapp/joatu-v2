class Pod < ActiveRecord::Base
  has_one :hub, through: :hub_organization_relation, source: :organization
  has_one :hub_organization_relation, class: PodHubRelation, dependent: :destroy

  # NOTE: The custom select DISTINCT ON query is required because the ideal way
  # of doing this (simply using AR's "uniq" method does a plain "DISTINCT",
  # which fails on postgres 9.3 for tables with JSON columns (which user does).
  # Once Amazon RDS updates to postgres 9.4 and we can convert to JSONb columns
  # we should no longer have this problem, and should revert the scope to this:
  # -> { uniq }
  #
  has_many :members, -> { select("DISTINCT ON (users.id) users.*") }, class: User, through: :pod_memberships, source: :user
  has_many :pod_memberships

  has_many :events, dependent: :destroy

  # Returns the current "best pod" for the user, based on "our algorythm".
  # Really just tries to geocode a point from the user's postal code, and then
  # find any pods that focus on that point. If there's a match, the first pod
  # wins. Otherwise we return an instance of UncreatedPod.
  def self.best_for_user(user)
    return UncreatedPod.new if user.postal_code.blank?

    lat,lng = Geocoder.coordinates(user.postal_code)
    return UnCreatedPod.new if lat.blank? || lng.blank?

    pods = where("ST_Contains(focus_area, ST_PointFromText('POINT(#{lng} #{lat})'))")

    pods.first || UncreatedPod.new
  end

  def to_geojson
    return "" if self.new_record?

    feature = RGeo::GeoJSON::Feature.new(self.focus_area)
    RGeo::GeoJSON.encode(feature).to_json
  end

  def map_bounds
    min_x = min_y = 1000
    max_x = max_y = -1000
    self.focus_area.exterior_ring.points.each do |point|
      min_x = point.x if point.x < min_x
      min_y = point.y if point.y < min_y

      max_x = point.x if point.x > max_x
      max_y = point.y if point.y > max_y
    end

    [[min_y, min_x], [max_y, max_x]]
  end

  def hub_id
    hub.try(:id)
  end

  def hub_id=(val)
    self.hub = Organization.find(val)
  end
end
