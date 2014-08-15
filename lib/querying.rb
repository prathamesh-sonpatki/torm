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
      self.connection
      .exec_query("SELECT COUNT(*) FROM #{self.table_name}")[0]['count'].to_i
    end

    def delete_all
      delete_manager = Arel::DeleteManager.new table.engine
      delete_manager.from table
      self.connection.exec_query delete_manager.to_sql
    end

    def last
      last_id = connection.last_inserted_id(primary_key_sequence)
      find last_id
    end

    private

    def primary_key_sequence
      "#{table_name}_id_seq"
    end
  end
end
