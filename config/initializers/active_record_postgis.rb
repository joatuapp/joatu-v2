ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.tap do |klass|
  klass::OID.register_type('geometry', klass::OID::Identity.new)
end
