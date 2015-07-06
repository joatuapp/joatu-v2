class MigrateOfferRequestTypes < ActiveRecord::Migration
  def up
    sql = "UPDATE offers_and_requests SET detail_type = 'physical_goods', type = 'Offer' WHERE type = 'Offer::PhysicalGoods'"
    ActiveRecord::Base.connection.execute sql

    sql = "UPDATE offers_and_requests SET detail_type = 'knowledge', type = 'Offer' WHERE type = 'Offer::Knowledge'"
    ActiveRecord::Base.connection.execute sql

    sql = "UPDATE offers_and_requests SET detail_type = 'skills_and_time', type = 'Offer' WHERE type = 'Offer::SkillsAndTime'"
    ActiveRecord::Base.connection.execute sql

    sql = "UPDATE offers_and_requests SET detail_type = 'physical_goods', type = 'Request' WHERE type = 'Request::PhysicalGoods'"
    ActiveRecord::Base.connection.execute sql

    sql = "UPDATE offers_and_requests SET detail_type = 'knowledge', type = 'Request' WHERE type = 'Request::Knowledge'"
    ActiveRecord::Base.connection.execute sql

    sql = "UPDATE offers_and_requests SET detail_type = 'skills_and_time', type = 'Request' WHERE type = 'Request::SkillsAndTime'"
    ActiveRecord::Base.connection.execute sql
  end

  def down
    sql = "UPDATE offers_and_requests SET type = 'Offer::PhysicalGoods' WHERE type = 'Offer' AND detail_type = 'physical_goods'"
    ActiveRecord::Base.connection.execute sql

    sql = "UPDATE offers_and_requests SET type = 'Offer::Knowledge' WHERE type = 'Offer' AND detail_type = 'knowledge'"
    ActiveRecord::Base.connection.execute sql

    sql = "UPDATE offers_and_requests SET type = 'Offer::SkillsAndTime' WHERE type = 'Offer' AND detail_type = 'skillsandtime'"
    ActiveRecord::Base.connection.execute sql

    sql = "UPDATE offers_and_requests SET type = 'Request::PhysicalGoods' WHERE type = 'Request' AND detail_type = 'physical_goods'"
    ActiveRecord::Base.connection.execute sql

    sql = "UPDATE offers_and_requests SET type = 'Request::Knowledge' WHERE type = 'Request' AND detail_type = 'knowledge'"
    ActiveRecord::Base.connection.execute sql

    sql = "UPDATE offers_and_requests SET type = 'Request::SkillsAndTime' WHERE type = 'Request' AND detail_type = 'skillsandtime'"
    ActiveRecord::Base.connection.execute sql

  end
end
