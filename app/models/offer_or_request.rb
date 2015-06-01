# NOTE: This class is an abstract base class for the
# offers_or_requests table. It should not be instantiated directly, use the
# Offer or Request models, or their descendents.
class OfferOrRequest < Base
  self.abstract_class = true
  self.table_name = "offers_and_requests"

  include PgSearch

  belongs_to :user
  belongs_to :pod

  has_many :offer_or_request_access_control

  validates :visibility, inclusion: { in: %w(public private) }

  DETAIL_TYPES = {
    knowledge: 'knowledge',
    physical_goods: 'physical_goods',
    skills_and_time: 'skills_and_time',
  }

  pg_search_scope :text_search, lambda {|query, lang, order = nil|
    dictionary = (lang == :fr) ? "french" : "english"
    search_scope = {
      query: query,
      against: {
        title: "A",
        description: "C",
      },
      ignoring: :accents,
      using: {
        tsearch: {
          dictionary: dictionary,
          any_word: true,
        }
      }
    }
    case order
    when :created_at_desc
      search_scope[:order_within_rank] = "#{self.table_name}.created_at DESC"
    when :created_at_asc
      search_scope[:order_within_rank] = "#{self.table_name}.created_at ASC"
    end

    search_scope
  }

  def self.owned_by(user)
    Just(user)
    where(user_id: user.id)
  end

  def self.available_to(user)
    pod_id = Pod.home_pod_for_user(user).id
    org_ids = OrganizationMembership.where_user_is_member(user).pluck(:organization_id)

    query = self.joins("LEFT OUTER JOIN offer_and_request_access_controls ON offers_and_requests.id = offer_and_request_access_controls.offer_or_request_id")
    query = query.where("offers_and_requests.visibility = 'public' OR offer_and_request_access_controls.id IS NOT NULL")
    if org_ids.empty?
      query = query.where("(offer_and_request_access_controls.group_type = 'Pod' AND offer_and_request_access_controls.group_id = #{pod_id})")
    else
      query = query.where("(offer_and_request_access_controls.group_type = 'Pod' AND offer_and_request_access_controls.group_id = #{pod_id}) OR (offer_and_request_access_controls.group_type = 'Organization' AND offer_and_request_access_controls.group_id IN (#{org_ids.join(',')}))")
    end
  end

  def self.search_results(search_data)
    query = self

    # Only add text search conditions if a search key is given:
    if search_data[:search].present?
      query = query.text_search(search_data[:search], I18n.locale, search_data[:order_by])
    else
      # NOTE: This search is in an "else" block, as the text_search scope will
      # handle order for us, IF it is used. This is a fallback for ordering
      # when not doing a text search:
      case search_data[:order_by]
      when :created_at_desc
        query = query.order(created_at: :desc)
      when :created_at_asc
        query = query.order(created_at: :asc)
      end
    end

    if search_data[:types_filter].present?
      query = query.where(type: search_data[:types_filter])
    end

    query
  end

  def self.detail_type_options
    {
      "Knowledge" => DETAIL_TYPES[:knowledge],
      "Physical Goods" => DETAIL_TYPES[:physical_goods],
      "Skills and Time" => DETAIL_TYPES[:skills_and_time],
    }
  end

  def self.valid_detail_types
    DETAIL_TYPES.values
  end

  def type_class
    self.class.name.demodulize.underscore
  end
end
