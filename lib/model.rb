module Torm
  class Model
    def self.create(params = {})
    end

    def self.update(params = {})
    end

    def self.destroy(params)
    end

    def self.find(id)
      where(id: id)
    end

    def self.table
      @_table ||= Arel::Table.new(self.name.downcase + 's', Torm::Engine.new)
    end

    def self.where(options)
      k, v   = options.shift
      clause = table[k].eq v
      options.each do |k, v|
        clause = clause.and(table[k].eq(v))
      end
      table.where(clause)
    end
  end
end