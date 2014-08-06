require 'pg'
require 'arel'

module PG
  class Connection
    def schema_cache
      FakeSchemaCache.new
    end

    def quote_table_name arg
      arg
    end

    def quote_column_name arg
      arg
    end

    def quote value, column = nil
      "'#{value.to_s}'"
    end
  end
end

class FakeEngine
  attr_reader :connection
  def initialize
    @connection = FakeConnection.new
  end
end

class FakeConnection
  attr_reader :connection, :visitor
  def initialize
    @connection = PG::Connection.open(:dbname => 'backpackers_development')
    @visitor = Arel::Visitors::PostgreSQL.new @connection
  end
end

class FakeSchemaCache
  def table_exists? name
    true
  end

  def columns_hash arg
    { locations: 'location_type' }
  end
end

engine = FakeEngine.new

locations = Arel::Table.new('locations', engine)

q = locations.where(locations[:location_type].eq('hotel')).project('*').to_sql

puts "QUERY =>"
puts q

result = engine.connection.connection.exec q

puts result[0]

#=> {"id"=>"4", "name"=>"Akhibara", "area"=>nil, "location_type"=>"hotel", "parent_location_id"=>nil, "created_at"=>nil, "updated_at"=>nil, "distance_from_parent"=>nil}
