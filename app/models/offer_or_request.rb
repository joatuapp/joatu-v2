# NOTE: This class is an abstract base class for the
# offers_or_requests table. It should not be instantiated directly, use the
# Offer or Request models, or their descendents.
class OfferOrRequest < Base
  self.abstract_class = true
  self.table_name = "offers_and_requests"

  include PgSearch

  belongs_to :created_by_user, class_name: "User"

  # Offers and Requests _may_ belong to an organization. If they do, that
  # offer / request will be visible only to members of that organization, or
  # depending on the value of organization_privacy, just the org's admins.
  belongs_to :organization

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

  def self.summary_for_pod(pod)
    # TODO: Figure out what code to put here, how do we determine what a
    # summary of offers/ requests for a given pod is?
    #
    all
  end

  def self.owned_by(user)
    if Actual(user)
      where(created_by_user_id: user.id)
    else
      none
    end
  end

  def self.available_to(user)
    query = self
    org_ids = OrganizationMembership.where_user_is_member(user).pluck(:organization_id)

    if org_ids.empty?
      query = query.where(organization_id: nil)
    elsif org_ids.size == 1
      query = query.where("organization_id IS NULL OR organization_id = #{org_ids.first}")
    else
      query = query.where("organization_id IS NULL OR organization_id = IN(#{org_ids.join(", ")})")
    end
  end

  def self.organization_public_collection(org)
    self.where(created_by_organization_id: org.id)
  end

  def self.organization_member_collection(org)
    self.where("created_by_organization_id = #{org.id} OR organization_id = #{org.id}")
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
      query = query.where(detail_type: search_data[:types_filter])
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

  def created_by
    created_by_user
  end

  def created_by_name
    created_by.name
  end
end
