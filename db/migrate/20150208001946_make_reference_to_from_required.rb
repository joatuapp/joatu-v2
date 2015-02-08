class MakeReferenceToFromRequired < ActiveRecord::Migration
  def change
    change_column_null :references, :from_user_id, false
    change_column_null :references, :to_user_id, false
  end
end
