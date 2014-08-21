module Torm
  class SchemaCache
    def initialize connection
      @connection = connection
      @columns = {}
      @columns_hash = {}
    end

    def table_exists? name
      true
    end

    def columns(table_name)
      @columns[table_name] ||= @connection.columns table_name
    end

    def columns_hash(table_name)
      @columns_hash[table_name] ||= Hash[columns(table_name).map { |col|
                                           [col.name, col]
        }]
    end
  end
end
