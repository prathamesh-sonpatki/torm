module Torm
  module DatabaseStatements
    def create attributes
      new_record = new(attributes)
      insert_manager = Arel::InsertManager.new table.engine
      insert_manager.into table
      insert_manager.insert new_record.current_attribute_values(attributes)
      connection.exec_query insert_manager.to_sql
      last
    end

    def destroy id
      delete_manager = Arel::DeleteManager.new table.engine
      delete_manager.from table
      delete_manager.where table[:id].eq id
      self.connection.exec_query delete_manager.to_sql
    end

    def find(id)
      find_clause = where(id: id)
      find_clause = find_clause.project('*')
      result_hash = connection.exec_query(find_clause.to_sql)[0]
      new(result_hash)
    end
  end
end
