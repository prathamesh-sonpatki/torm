require 'rubygems'
require 'minitest/autorun'
require 'fileutils'
require './lib/torm'
Dir["test/support/*.rb"].each {|file| require file }

class Object
  def must_be_like other
    gsub(/\s+/, ' ').strip.must_equal other.gsub(/\s+/, ' ').strip
  end
end

module Torm
  class Test < MiniTest::Test
    def assert_like expected, actual
      assert_equal expected.gsub(/\s+/, ' ').strip,
                   actual.gsub(/\s+/, ' ').strip
    end
  end
end
