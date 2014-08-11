require './lib/torm'

class Post < Torm::Model
end

p Post.where(id: 1).to_sql
