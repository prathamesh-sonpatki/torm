module Torm
  module Adapters
    class Pgconnection
      def initialize(options = {})
        @connection = PG.connect(:dbname => 'torm_development')
      end

      def visitor
        @visitor = Arel::Visitors::PostgreSQL.new self
      end

      def schema_cache
        Torm::SchemaCache.new self
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

      def columns table
        column_definitions(table).values.map do |column_name, type, default, notnull, oid, fmod|
          cast_type = lookup_cast_type(type)
          Torm::Column.new(column_name, type, cast_type)
        end
      end

      def column_definitions(name)
        @connection.exec(%Q(SELECT a.attname, format_type(a.atttypid, a.atttypmod),
                     pg_get_expr(d.adbin, d.adrelid), a.attnotnull, a.atttypid, a.atttypmod
                FROM pg_attribute a LEFT JOIN pg_attrdef d
                  ON a.attrelid = d.adrelid AND a.attnum = d.adnum
                  WHERE a.attrelid = '#{name}'::regclass
                 AND a.attnum > 0 AND NOT a.attisdropped
               ORDER BY a.attnum))
      end

      def type_map
        @type_map ||= Type::TypeMap.new.tap do |mapping|
          initialize_type_map(mapping)
        end
      end

      def lookup_cast_type(sql_type) # :nodoc:
        type_map.lookup(sql_type)
      end

      def initialize_type_map mapping
        register_type_class mapping, %r(char)i, Type::String
        register_type_class mapping, %r(int)i, Type::Integer
      end

      def register_type_class(mapping, key, klass)
        mapping.register_type(key, klass.new)
      end

    end
  end
end
