# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if ENV["INITIAL_ADMIN_EMAIL"] && ENV["INITIAL_ADMIN_PASSWORD"]
  unless User.find_by_email(ENV["INITIAL_ADMIN_EMAIL"]).present?
    User.create({
      email: ENV["INITIAL_ADMIN_EMAIL"],
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
  description = <<-TEXT.squish
    Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem.

    Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a
  TEXT
  
  first_pod_params = {
    hub_id: 1, 
    name: "Coop Sur Genereux", 
    description: description,
    focus_area: "POLYGON ((-73.57838988304138 45.51188068140241, -73.56929183006287 45.52306687976776, -73.57924818992615 45.52787746396651, -73.58989119529724 45.51669222205489, -73.57838988304138 45.51188068140241))",
  }
  first_pod = Pod.create(first_pod_params)

  if ENV["INITIAL_ADMIN_EMAIL"] && ENV["INITIAL_ADMIN_PASSWORD"]
    u = User.find_by_email(ENV["INITIAL_ADMIN_EMAIL"])
    u.pod = Pod.first

    u.save!
  end
end
