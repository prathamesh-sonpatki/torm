module Torm
  class AttributeSet
    class Builder
      attr_reader :types

      def initialize(types)
        @types = types
      end

      def build_from_database(values = {})
        attributes = build_attributes_from_values(values)
        add_uninitialized_attributes(attributes)
        AttributeSet.new(attributes)
      end

      private

      def build_attributes_from_values(values)
        values.each_with_object({}) do |(name, value), hash|
          hash[name] = Attribute.from_database(name, value, value.cast_type)
        end
      end

      def add_uninitialized_attributes(attributes)
        types.except(*attributes.keys).each do |name, type|
          attributes[name] = Attribute.uninitialized(name, type)
        end
      end
    end
  end
end
