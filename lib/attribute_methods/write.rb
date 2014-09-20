module Torm
  module AttributeMethods
    module Write
      def init_writer(attr_name)
        self.singleton_class.define_method("#{attr_name}=") do |value|
          write_attribute(attr_name, value)
        end
      end

      def write_attribute(name, value)
        write_attribute_with_type_cast(name, value, true)
      end

      def write_attribute_with_type_cast(attr_name, value, should_type_cast)
        if should_type_cast
          @attributes.write_from_user(attr_name, value)
        else
          @attributes.write_from_database(attr_name, value)
        end
        value
      end
    end
  end
end
