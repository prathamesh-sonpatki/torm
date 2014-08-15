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

    def test_create_with_inline_parameters_creates_new_record
      Post.delete_all
      Post.create subject: "Lol Nom Rom"
      assert_equal 1, Post.count
    end

    def test_save_creates_new_record
      Post.delete_all
      post = Post.new subject: "Lol Nom Rom"
      post.save
      assert_equal 1, Post.count
    end

    def test_delete_all_creates_sql
      Post.delete_all
      post = Post.new subject: "Lol Nom Rom"
      post.save
      assert_equal 1, Post.count
      Post.delete_all
      assert_equal 0, Post.count
    end

    def test_save_returns_the_record_in_ruby_format
      Post.delete_all
      post = Post.create subject: "Lol Nom Rom"
      assert_equal 'Lol Nom Rom', post.reload.subject
    end

    def test_update_existing_record_using_save
      Post.delete_all
      post = Post.create subject: "Lol Nom Rom"
      post.reload
      assert_equal 'Lol Nom Rom', post.subject
      post.subject = 'ZOMG!'
      post.save
      assert_equal 'ZOMG!', post.reload.subject
      assert_equal '', post.reload.author
      post.author = 'Prathamesh'
      post.save
      assert_equal 'Prathamesh', post.reload.author
    end

    def test_update_existing_record_using_update
      Post.delete_all
      post = Post.create subject: "Lol Nom Rom"
      post.reload
      assert_equal 'Lol Nom Rom', post.subject
      post.update(subject: 'ZOMG!')
      assert_equal 'ZOMG!', post.reload.subject
    end

    def test_destroy_deletes_record_with_given_id_if_record_exists
      Post.delete_all
      post = Post.create subject: "Lol Nom Rom"
      Post.destroy post.id
      assert_equal 0, Post.count
    end
  end
end
