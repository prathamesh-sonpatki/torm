require 'test/helper'

module Torm
  class TestModel < Minitest::Test

    def test_accepts_where_clause
      assert_equal "SELECT FROM posts  WHERE posts.id = 1", Post.where(id: 1).to_sql
    end

  end
end