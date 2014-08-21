module Torm
  module Querying

    def where(options)
      k, v   = options.shift
      clause = table[k].eq v
      options.each do |field, value|
        clause = clause.and(table[field].eq(value))
      end
      table.where(clause)
    end

    def count
      connection.exec_query("SELECT COUNT(*) FROM #{self.table_name}")[0]['count'].to_i
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
