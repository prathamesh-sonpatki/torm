module Torm
  module Type
    class String < Value
      def type
        :string
      end

      def type_cast_for_database(value)
        case value
          when ::Numeric
            value.to_s
          when ::String
            ::String.new(value)
          when true
            "1"
          when false
            "0"
          else
            super
        end
      end

    end
  end
end
