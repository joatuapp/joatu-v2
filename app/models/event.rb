class Event < ActiveRecord::Base
  belongs_to :creator, class: User, foreign_key: :created_by_user_id
  belongs_to :organization

  composed_of :address, mapping: %w(address_json to_json)
end
