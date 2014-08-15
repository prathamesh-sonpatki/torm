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
