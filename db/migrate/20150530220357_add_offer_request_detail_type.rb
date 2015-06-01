class AddOfferRequestDetailType < ActiveRecord::Migration
  def change
    add_column :offers_and_requests, :detail_type, :string, after: :type
  end
end
