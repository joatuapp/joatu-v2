# ActiveRecrod will `warn` (to stdout) when first connecting to the adapter:
#  unknown OID 16391: failed to recognize type of 'geo'. It will be treated as...

# Registering the `geometry` type (typically not supported by Active Record) will
# prevent this warning but AR will continue to treat it the same. This cleans up
# logs and test output.

ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.class_eval do
  def initialize_type_map_with_postgres_oids mapping
    initialize_type_map_without_postgres_oids mapping
    register_class_with_limit mapping, 'geometry',
      ActiveRecord::ConnectionAdapters::PostgreSQLAdapter::OID::Integer
  end

  alias_method_chain :initialize_type_map, :postgres_oids
end
