class Hash
  def transform_values
    result = self.class.new
    each do |key, value|
      result[key] = yield(value)
    end
    result
  end

  def transform_keys
    result = self.class.new
    each_key do |key|
      result[yield(key)] = self[key]
    end
    result
  end


  def except(*keys)
    dup.except!(*keys)
  end

  def except!(*keys)
    keys.each { |key| delete(key) }
    self
  end

  def stringify_keys
    transform_keys{ |key| key.to_s }
  end

end