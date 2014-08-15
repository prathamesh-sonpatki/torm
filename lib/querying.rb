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
      self.connection.exec_query dm.to_sql
    end

    def create attributes
      cm = Arel::InsertManager.new table.engine
      cm.into table
      cm.insert attributes
      connection.exec_query cm.to_sql
    end
  end
end
