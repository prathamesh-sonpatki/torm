module Torm
  module Naming

    def table_name
      @_table_name ||= table.name
    end

    def table_name=(name)
      @_table_name =name
    end
  end
end