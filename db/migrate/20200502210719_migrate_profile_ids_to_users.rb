class MigrateProfileIdsToUsers < ActiveRecord::Migration[5.2]
  def up
    Profile.all.each do |profile|
      next if profile.user_id.blank?

      user = User.find(profile.user_id)
      user.profile_id = profile.id
      user.save
    end

    change_column_null(:profiles, :user_id, true)
  end

  def down; end
end
