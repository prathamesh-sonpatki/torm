# name
# # sql_type
# # cast_type
module Torm
  class Column
    attr_accessor :name, :sql_type, :cast_type

    def initialize(name, sql_type, cast_type)
      @name = name
      @sql_type = sql_type
      @cast_type = cast_type
    end
  end
end
