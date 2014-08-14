module Torm
  module Type
    class Value

      def type; end

      def type_cast_for_database(value)
        value
      end

      alias :type_cast :type_cast_for_database

    end
  end
end