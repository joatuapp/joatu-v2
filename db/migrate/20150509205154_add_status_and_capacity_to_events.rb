class AddStatusAndCapacityToEvents < ActiveRecord::Migration
  def change
    add_column :events, :status, :string, default: 'approved', null: false
    add_column :events, :capacity, :integer, default: 0, null: true
  end
end
