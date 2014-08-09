module Torm
  class SchemaCache
    def initialize connection
    end
    def table_exists? name
      true
    end
    def columns_hash arg
    { posts: 'author' }
    end
  end
end
