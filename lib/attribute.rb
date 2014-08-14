module Torm
  class Attribute
    attr_reader :name, :value_before_type_cast, :type

    class << self
      def from_database(name, value, type)
        FromDatabase.new(name, value, type)
      end

      def from_user(name, value, type)
        FromUser.new(name, value, type)
      end

    end

    def initialize(name, value_before_type_cast, type)
      @name                   = name
      @value_before_type_cast = value_before_type_cast
      @type                   = type
    end

    def value
      @value ||= type_cast(value_before_type_cast)
    end

    def value_for_database
      type.type_cast_for_database(value)
    end

    def with_value_from_user(value)
      self.class.from_user(name, value, type)
    end

    def with_value_from_database(value)
      self.class.from_database(name, value, type)
    end


    protected
    class FromDatabase < Attribute
      def type_cast(value)
        type.type_cast_from_database(value)
      end
    end

    class FromUser < Attribute
      def type_cast(value)
        type.type_cast_from_user(value)
      end
    end

    private_constant :FromDatabase, :FromUser
  end
end
