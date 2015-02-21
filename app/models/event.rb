class Event < ActiveRecord::Base
  before_save :write_address

  belongs_to :creator, class: User, foreign_key: :created_by_user_id
  belongs_to :organization

  def address
    @address ||= Address.new(super)
  end

  private

  def write_address
    write_attribute(:address, address.to_json)
  end
end
