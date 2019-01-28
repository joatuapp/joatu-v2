# NOTE: This class is an abstract base class for the
# offers_or_requests table. It should not be instantiated directly, use the
# Offer or Request models, or their descendents.
class OfferOrRequest < Base
  self.abstract_class = true
  self.table_name = "offers_and_requests"

  include PgSearch

  belongs_to :user
  belongs_to :pod

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

  def self.visible_to_pod(pod)
    if Actual(pod)
      where(pod_id: [nil, pod.id])
    else
      where(pod_id: nil)
    end
  end

  def self.owned_by(user, pagination)
    Just(user)
    where(user_id: user.id).paginate(pagination)
  end

  def self.available_to(user, pagination)
    pod = user.pod
    visible_to_pod(pod).includes(user: [:profile]).paginate(pagination)
  end

  def self.search_results(search_data, user, pagination)
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

    query = query.available_to(user, pagination)

    query
  end

  def type_class
    self.class.name.demodulize.underscore
  end

  def self.valid_types
    descendants.map {|c| c.name }
  end

  def self.type_options
    descendants.inject({}) do |h, c|
      h[I18n.t("offers_and_requests.types.#{c.name.demodulize.underscore}")] = c.name.to_s

      h
    end
  end
end
