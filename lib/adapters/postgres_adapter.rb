module Torm
  module Adapters
    class Pgconnection
      def initialize(options = {})
        @connection = PG.connect(:dbname => 'demo')
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
    end
  end
end
