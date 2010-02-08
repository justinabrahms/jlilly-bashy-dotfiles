#!/usr/bin/env ruby

# For use with ri.el: http://www.emacswiki.org/cgi-bin/wiki/RiEl

require 'rubygems'
gem 'rdoc', '>= 2.2.1'
require 'rdoc/ri/driver'
require 'stringio'

module RDoc::RI
  # Don't let the script die, even if there's an error.
  class Driver; def abort(msg); warn msg end end
  @driver = Driver.new # Piggy-back on a built-in RI class

  module_function

  def repl(input = $stdin)
    loop do
      $stdout = StringIO.new
      if((string = input.gets.chomp) =~ /^Complete: (.+)$/)
        STDOUT.puts complete(Regexp.last_match[1])
      else
        Driver.run [string]
        $stdout.rewind
        STDOUT.puts $stdout.read
      end
    end
  end

  def complete(string)
    if string =~ /(#|::[a-z]|\.[a-z])/
      complete_absolute_method(string)
    elsif string =~ /^[A-Z]/
      cache.keys.grep(/^#{string}/)
    else
      complete_method_only(string)
    end.join("\n")
  end

  def complete_absolute_method(string, methods = [])
    klass, method = @driver.parse_name(string)
    pattern = /^#{method}/

    cache[klass]["instance_methods"].map{|h|h["name"]}.grep(pattern) do |name|
      methods << klass + '#' + name
    end
    cache[klass]["class_methods"].map{|h|h["name"]}.grep(pattern) do |name|
      methods << klass + '::' + name
    end
    return methods
  end

  def complete_method_only(string, methods = [])
    pattern = /^#{string}/
    cache.keys.sort.each do |klass|
      cache[klass]["instance_methods"].map{|h|h["name"]}.grep(pattern) do |name|
        methods << klass + '#' + name if load_cache_for(klass)[klass+'#'+name]
      end
      cache[klass]["class_methods"].map{|h|h["name"]}.grep(pattern) do |name|
        methods << klass + '::' + name  if load_cache_for(klass)[klass+'::'+name]
      end
    end
    return methods
  end

  def cache; @driver.class_cache end
  def load_cache_for(k); @driver.load_cache_for(k) end
end
RDoc::RI.repl if __FILE__ == $0
