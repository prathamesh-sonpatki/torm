require 'test/helper'

module Torm
  class TestNaming < Minitest::Test

    def teardown
      Post.table_name = nil
    end

    def test_sets_default_table_name
      assert_equal 'posts', Post.table_name
    end

    def test_assigning_custom_table_name
      Post.table_name= "blog_posts"
      assert_equal 'blog_posts', Post.table_name
    end
  end
end