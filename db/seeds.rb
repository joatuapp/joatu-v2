# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if ENV["INITIAL_ADMIN_PASSWORD"]
  unless User.find_by_email("alex@undergroundwebdevelopment").present?
    User.create({
      email: "alex@undergroundwebdevelopment.com",
      password: ENV["INITIAL_ADMIN_PASSWORD"],
      password_confirmation: ENV["INITIAL_ADMIN_PASSWORD"],
      is_admin: true,
      confirmed_at: Time.now,
    })
  end
end
