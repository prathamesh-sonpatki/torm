require 'test/helper'

module Torm
  class TestModel < Minitest::Test

    def test_accepts_where_clause
      assert_equal "SELECT FROM posts  WHERE posts.id = 1", Post.where(id: 1).to_sql
    end

    def test_creates_appropriate_arel_table
      table = Post.table
      assert_instance_of Arel::Table, table
      assert_equal  'posts', table.name
    end

    def test_initialize_allows_setting_attributes
      post = Post.new subject: "Lol Nom Rom"
      assert_equal "Lol Nom Rom", post.subject
    end

    def test_initialize_creates_empty_object
      post = Post.new
      assert_equal nil, post.id
      assert_equal nil, post.name
      assert_equal nil, post.author
      assert_equal nil, post.subject
    end

    def test_save_creates_new_record
      Post.delete_all
      post = Post.new subject: "Lol Nom Rom"
      assert_equal 1, Post.count
    end

    def test_delete_all_creates_sql
      assert_equal "DELETE FROM posts", Post.delete_all
    end

  end
end
