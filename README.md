# Torm [![Build Status](https://travis-ci.org/prathamesh-sonpatki/torm.svg?branch=master)](http://travis-ci.org/prathamesh-sonpatki/torm)

* http://github.com/prathamesh-sonpatki/torm

## DESCRIPTION

Oh Really Magical, Tiny ORM

## Does it work?

Yes. First create database:

```
psql
create database torm_development;
\c torm_development;
CREATE TABLE posts ( id integer primary key, name varchar(20), content text, author varchar(100), subject varchar(1000));
```

Now run tests:

```
bundle exec rake test
```

## What can it do?

Check the model tests, to find complete list of operations. 

## Usage

```ruby
class Post < Torm::Model
end

post = Post.new subject: 'What is RGenCG?'
post.save

first_post = Post.find(1)
puts first_post.subject
=> 'What is RGenCG?'

first_post.subject = 'What is RincCG?'
first_post.save
puts Post.find(1).subject
=> 'What is RincCG?'
  
Post.where(id: 1).subject
=> 'What is RincCG?'
   
Post.count
=> 1

Post.delete_all
Post.count
=> 0
```
