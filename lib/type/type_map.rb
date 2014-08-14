module Torm
  module Type
    class TypeMap
      def initialize
        @mapping = {}
      end

      def lookup(lookup_key)
        matching_pair = @mapping.reverse_each.detect do |key, _|
          key === lookup_key
        end

        if matching_pair
          matching_pair.last
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
