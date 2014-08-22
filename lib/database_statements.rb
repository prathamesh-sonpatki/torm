module Torm
  module DatabaseStatements

    def save attributes = {}
      if persisted?
        update attributes
      else
        self.class.create attributes
      end
    end

    def create attributes = {}
      new_record = new(attributes)
      insert_manager = Arel::InsertManager.new table.engine
      insert_manager.into table
      insert_manager.insert new_record.current_attribute_values(attributes)
      connection.exec_query insert_manager.to_sql
      last
    end

    def update attributes = {}
      update_manager = Arel::UpdateManager.new self.class.table.engine
      update_manager.table self.class.table
      update_manager.where self.class.table[:id].eq id
      update_manager.set current_attribute_values(attributes)
      self.class.connection.exec_query update_manager.to_sql
      self.class.find id
    end

    def destroy id
      delete_manager = Arel::DeleteManager.new table.engine
      delete_manager.from table
      delete_manager.where table[:id].eq id
      self.connection.exec_query delete_manager.to_sql
    end

    def last
      last_id = connection.last_inserted_id(primary_key_sequence)
      find last_id
    end

    def find id
      find_clause = where(id: id)
      find_clause = find_clause.project('*')
      result_hash = connection.exec_query(find_clause.to_sql)[0]
      new(result_hash)
    end
  end
end
