module Torm
  module Type
    class Value

      def type; end

      def type_cast_for_database(value)
        value
      end

      def type_cast_from_database(value)
        value unless value.nil?
      end

      alias :type_cast :type_cast_for_database
      alias :type_cast_from_user :type_cast
    end
  end
end
