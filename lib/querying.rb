module Torm
  module Querying

    def where(options)
      table.where(
        options.inject(nil) do |clause, (k, v)|
          comparison = table[k].eq(v)
          clause ? clause.and(comparison) : comparison
        end
      )
    end

    def count
      query = Arel::SelectManager.new(table.engine).from(self.table_name).project(table[Arel.star].count)
      connection.exec_query(query.to_sql)[0]['count'].to_i
    end

    def delete_all
      delete_manager = Arel::DeleteManager.new table.engine
      delete_manager.from table
      connection.exec_query delete_manager.to_sql
    end

    private

    def primary_key_sequence
      "#{table_name}_id_seq"
    end
  end
end
