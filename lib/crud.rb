module Torm
  module Crud
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
      new(connection.exec_query(where(id: id).project('*').to_sql)[0])
    end
  end
end
