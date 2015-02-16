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

unless Organization.exists?
  first_hub_params = {
    id: 1,
    name: "Coop Sur Genereux", 
    description: "The cooperative home, now in its twelfth year, is a community intent on creating and maintaining a holistic and harmonious way of life. Coop Sur Généreux has an open-door policy inviting collaboration, creativity and community building. They welcome skill-sharing, communal cooking and a safe space for exchange.",
  }

  Organization.create(first_hub_params)
end

unless Pod.exists?
  first_pod_params = {
    hub_id: 1, 
    name: "Coop Sur Genereux", 
    focus_area: "POLYGON ((-73.57838988304138 45.51188068140241, -73.56929183006287 45.52306687976776, -73.57924818992615 45.52787746396651, -73.58989119529724 45.51669222205489, -73.57838988304138 45.51188068140241))",
  }
  first_pod = Pod.create(first_pod_params)

  User.find_each do |user|
    user.home_pod = first_pod unless user.home_pod
    user.save
  end
end
