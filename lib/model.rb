module Torm
  class Model
    include ModelSchema
    extend Naming
    extend Querying
    extend DatabaseStatements
    include DatabaseStatements
    include Torm::AttributeMethods::Write
    include Torm::AttributeMethods::Read

    def initialize(user_attributes = {})
      @attributes = self.default_attributes.dup
      init_attribute_methods
      init_default_values
      init_user_attributes(user_attributes)
      self
    end

    def reload
      self.class.find id if persisted?
    end

    def persisted?
      !id.nil?
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

    def init_default_values
      column_names.each do |column|
        _assign_attribute(column, nil)
      end
    end

    def init_attribute_methods
      column_names.each do |column_name|
        init_writer column_name
        init_reader column_name
      end
    end

    def current_attribute_values(user_attributes = {})
      (self.column_names - ['id']).map do |column|
        attr = @attributes[column]
        [self.class.table[attr.name.intern], user_attributes.fetch(attr.name.intern, attr.value)]
      end
    end

    def self.table
      @_table ||= Arel::Table.new(self.name.downcase + 's', model_engine)
    end

    def self.model_engine
      @_model_engine ||= Torm::Engine.new
    end


    def self.connection
      @_model_connection ||= model_engine.connection
    end
  end
end
