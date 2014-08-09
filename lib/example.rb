require './lib/torm'

class Post < Model
end

Post.where(id: 1).to_sql
