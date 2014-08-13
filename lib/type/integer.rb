module Torm
  module Type
    class Integer < Value # :nodoc:

      def type
        :integer
      end

      def type_cast_for_database(value)
        case value
          when true
            1
          when false
            0
          else
            value.to_i rescue nil
        end
      end
    end
  end
end
