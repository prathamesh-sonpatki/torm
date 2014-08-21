module Torm
  module Adapters
    class Pgconnection
      def initialize(options = {})
        @connection = PG.connect(:dbname => 'torm_development')
      end

      def visitor
        @visitor = Arel::Visitors::PostgreSQL.new self
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

      def columns
        column_definitions('posts').values.map do |column|
          Torm::Column.new(column[0], column[1])
        end
      end

      # [["id", "integer", nil, "t", "23", "-1"], ["title", "text", nil, "f", "25", "-1"]]
      def column_definitions(name)
        @connection.exec(%Q(SELECT a.attname, format_type(a.atttypid, a.atttypmod),
                            pg_get_expr(d.adbin, d.adrelid), a.attnotnull, a.atttypid, a.atttypmod
                            FROM pg_attribute a LEFT JOIN pg_attrdef d
                            ON a.attrelid = d.adrelid AND a.attnum = d.adnum
                            WHERE a.attrelid = '#{name}'::regclass
                            AND a.attnum > 0 AND NOT a.attisdropped
                            ORDER BY a.attnum))
      end
    end
  end
end
