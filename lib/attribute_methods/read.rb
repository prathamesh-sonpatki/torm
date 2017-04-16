module Torm
  module AttributeMethods
    module Read
      def init_reader(attr_name)
        self.singleton_class.define_method(attr_name) do
          read_attribute(attr_name)
        end
      end

      def read_attribute(attr_name)
        name = attr_name.to_s
        @attributes.fetch_value(name)
      end
    end
  end
end
