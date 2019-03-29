class RemoveOffersSummaryField < ActiveRecord::Migration
  def up
    sql = "UPDATE offers_and_requests SET description = CONCAT(summary, ' ', description)"
    ApplicationRecord.connection.execute(sql)

    remove_column :offers_and_requests, :summary
  end
end
