module Torm
  module Adapters
    class PostgresAdapter
      def initialize
        @connection = PG.connect(:dbname => 'torm_development')
      end

      def visitor
        @visitor = Arel::Visitors::PostgreSQL.new self
      end

      def schema_cache
        @_schema_cache ||= Torm::SchemaCache.new self
      end

      def quote_table_name arg
        arg
      end

      def quote_column_name arg
        arg
      end

      def quote value, column = nil
        if column
          value = column.cast_type.type_cast_for_database(value)
        end
        "'#{value.to_s}'"
      end

      def table_exists? name
        exec_query(<<-SQL).first[0].to_i > 0
              SELECT COUNT(*)
              FROM pg_class c
              LEFT JOIN pg_namespace n ON n.oid = c.relnamespace
              WHERE c.relkind IN ('r','v','m') -- (r)elation/table, (v)iew, (m)aterialized view
              AND c.relname = '#{name}'
        SQL
      end

      def columns table
        column_definitions(table).values.map do |column_name, type, default, notnull, oid, fmod|
          cast_type = lookup_cast_type(type)
          Torm::Column.new(column_name, type, cast_type)
        end
      end

      def column_definitions(name)
        exec_query %Q(SELECT a.attname, format_type(a.atttypid, a.atttypmod),
                      pg_get_expr(d.adbin, d.adrelid), a.attnotnull, a.atttypid, a.atttypmod
                      FROM pg_attribute a LEFT JOIN pg_attrdef d
                      ON a.attrelid = d.adrelid AND a.attnum = d.adnum
                      WHERE a.attrelid = '#{name}'::regclass
                      AND a.attnum > 0 AND NOT a.attisdropped
                      ORDER BY a.attnum) , false
      end

      def type_map
        @type_map ||= Type::TypeMap.new.tap do |mapping|
          initialize_type_map(mapping)
        end
      end

      def lookup_cast_type(sql_type)
        type_map.lookup(sql_type)
      end

      def initialize_type_map mapping
        register_type_class mapping, %r(char)i, Type::String
        register_type_class mapping, %r(int)i, Type::Integer
      end

      def register_type_class(mapping, key, klass)
        mapping.register_type(key, klass.new)
      end

      def last_inserted_id(sequence_name)
        exec_query("SELECT currval('#{sequence_name}')").values.first.first
      end

      def exec_query sql, log = true
        puts sql if log
        @connection.exec sql
      end
    end
  end
end
