class Model
  def self.create(params = {})
  end

  def self.update(params = {})
  end

  def self.destroy(params)
  end

  def self.find(params)
  end

  def self.table
    Arel::Table.new(self.name.downcase + 's', Torm::Engine.new)
  end
end
