module Torm
  class Model
    include ModelSchema
    extend Querying
    include Torm::AttributeMethods::Write
    include Torm::AttributeMethods::Read

    def initialize(attributes = nil)
      @attributes = self.default_attributes.dup
      init_attribute_methods
      init_user_attributes(attributes)
    end

    def self.create(params = {})
    end

    def self.update(params = {})
    end

    def self.destroy(params)
    end

    def self.find(id)
      where(id: id)
    end

    def self.table
      @_table ||= Arel::Table.new(self.name.downcase + 's', Torm::Engine.new)
    end

    def self.table_name
      table.name
    end

    def self.connection
      self.table.engine.connection
    end

    def init_user_attributes attributes
      new_attributes = attributes.dup

      new_attributes = new_attributes.stringify_keys
      new_attributes.each do |k, v|
        _assign_attribute(k, v)
      end
    end

    def _assign_attribute(k, v)
      public_send("#{k}=", v)
    end

    def init_attribute_methods
      column_names.each do |column_name|
        init_writer column_name
        init_reader column_name
      end
    end
  end
end
