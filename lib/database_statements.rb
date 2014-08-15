module Torm
  module DatabaseStatements
    def create attributes
      new_record = new(attributes)
      cm = Arel::InsertManager.new table.engine
      cm.into table
      cm.insert new_record.current_attribute_values(attributes)
      connection.exec_query cm.to_sql
      last
    end

    def destroy id
      dm = Arel::DeleteManager.new table.engine
      dm.from table
      dm.where table[:id].eq id
      self.connection.exec_query dm.to_sql
    end

    def find(id)
      find_clause = where(id: id)
      find_clause = find_clause.project('*')
      result_hash = connection.exec_query(find_clause.to_sql)[0]
      new(result_hash)
    end
  end
end
