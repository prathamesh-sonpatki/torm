module Torm
  class AttributeSet

    class << self
      def build_from_database(attributes)
        AttributeSet.new(attributes)
      end
    end

    def initialize(attributes)
      @attributes = attributes
    end

    def [](name)
      attributes[name]
    end

    def fetch_value(name, &block)
      self[name].value(&block)
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
