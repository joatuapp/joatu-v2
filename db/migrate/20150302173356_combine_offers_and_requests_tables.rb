class CombineOffersAndRequestsTables < ActiveRecord::Migration
  def up
    rename_table :offers, :offers_and_requests
    change_table :offers_and_requests do |t|
      t.string :offer_or_request
      t.string :type
      t.index :offer_or_request
      t.index :type
    end

    # Set the offer_or_request column for all offers to 'offer'.
    sql = "UPDATE offers_and_requests SET offer_or_request = 'offer'"
    ActiveRecord::Base.connection.execute(sql)

    # Copy all requests into the offers table, with offer_or_request set to
    # 'request'
    sql = "INSERT INTO offers_and_requests (title, summary, description, created_at, updated_at, user_id, offer_or_request) SELECT title, summary, description, created_at, updated_at, user_id, 'request' as offer_or_request FROM requests;"
    ActiveRecord::Base.connection.execute(sql)
  end
end
