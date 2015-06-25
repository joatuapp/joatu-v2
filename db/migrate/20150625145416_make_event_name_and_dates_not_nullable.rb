class MakeEventNameAndDatesNotNullable < ActiveRecord::Migration
  def change
    change_column_null :events, :name, false
    change_column_null :events, :starts_at, false
    change_column_null :events, :ends_at, false
  end
end
