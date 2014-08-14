module Torm
  class AttributeSet

    def initialize(attributes)
      @attributes = attributes
    end

    def [](name)
      attributes[name]
    end

    def values_before_type_cast
      attributes.transform_values(&:value_before_type_cast)
    end

    def to_hash
      attributes.transform_values(&:value)
    end
    alias_method :to_h, :to_hash

    def key?(name)
      attributes.key?(name)
    end

    def write_from_database(name, value)
      attributes[name] = self[name].with_value_from_database(value)
    end

    def write_from_user(name, value)
      attributes[name] = self[name].with_value_from_user(value)
    end

    protected

    attr_reader :attributes

  end
end
