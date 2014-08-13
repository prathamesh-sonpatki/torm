module Torm
  module Type
    class TypeMap
      def initialize
        @mapping = {}
      end

      def lookup(lookup_key)
        if @mapping.key? lookup_key
          @mapping[lookup_key]
        else
          default_value
        end
      end

      def register_type(key, value = Value.new)
        @mapping[key] = value
      end

      def clear
        @mapping.clear
      end

      private

      def default_value
        @default_value ||= Value.new
      end
    end
  end
end
