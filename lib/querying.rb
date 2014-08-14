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
      .exec_query("SELECT COUNT(*) FROM #{self.table_name}")[0][1].to_i
    end

    def delete_all
      dm = Arel::DeleteManager.new table.engine
      dm.from table
      dm.to_sql
    end

  end
end