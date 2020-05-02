class AddProfileToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column(:users, :profile_id, :integer)
  end
end
