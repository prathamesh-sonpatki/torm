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
      post = Post.new subject: 'How RGenGC works?'
      assert_equal 'How RGenGC works?', post.subject
    end

    def test_initialize_creates_empty_object
      post = Post.new
      assert_equal nil, post.id
      assert_equal nil, post.name
      assert_equal nil, post.author
      assert_equal nil, post.subject
    end

    def test_create_with_inline_parameters_creates_new_record
      Post.delete_all
      Post.create subject: 'How RGenGC works?'
      assert_equal 1, Post.count
    end

    def test_save_creates_new_record
      Post.delete_all
      post = Post.new subject: 'How RGenGC works?'
      post.save
      assert_equal 1, Post.count
    end

    def test_delete_all_creates_sql
      Post.delete_all
      post = Post.new subject: 'How RGenGC works?'
      post.save
      assert_equal 1, Post.count
      Post.delete_all
      assert_equal 0, Post.count
    end

    def test_create_returns_the_record_with_relational_mapping
      Post.delete_all
      post = Post.create subject: 'How RGenGC works?'
      assert_equal 'How RGenGC works?', post.reload.subject
    end

    def test_update_existing_record_using_save
      Post.delete_all
      post = Post.create subject: 'How RGenGC works?'
      post.reload
      assert_equal 'How RGenGC works?', post.subject
      post.subject = 'How RincGC works?'
      post.save
      post.reload
      assert_equal 'How RincGC works?', post.subject
    end

    def test_update_existing_record_using_update
      Post.delete_all
      post = Post.create subject: 'How RGenGC works?'
      post2 = Post.create subject: 'How RGenGC works? ZOMG!!'
      post.reload
      assert_equal 'How RGenGC works?', post.subject
      post.update(subject: 'How RincGC works?')
      assert_equal 'How RincGC works?', post.reload.subject
      assert_equal 'How RGenGC works? ZOMG!!', post2.reload.subject
    end

    def test_destroy_deletes_record_with_given_id_if_record_exists
      Post.delete_all
      post = Post.create subject: 'How RGenGC works?'
      Post.destroy post.id
      assert_equal 0, Post.count
    end
  end
end
