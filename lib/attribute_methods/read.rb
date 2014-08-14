module Torm
  module AttributeMethods
    module Read
      def init_reader(attr_name)
        self.singleton_class.class_eval <<-RUBY, __FILE__, __LINE__ + 1
          def #{attr_name}
            read_attribute('#{attr_name}')
          end
        RUBY
      end

      def read_attribute(attr_name)
        name = attr_name.to_s
        @attributes.fetch_value(name)
      end
    end
  end
end
