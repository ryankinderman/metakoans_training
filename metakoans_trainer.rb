#!/usr/bin/env ruby
require File.dirname(__FILE__) + "/lib/trainer"

generate do
  section "Overview of the Ruby Type Structure" do

  code <<-eos
  class SomeClass
  end
  class DerivedClass < SomeClass
  end
  o = DerivedClass.new
  eos

  text <<-eos
  o is an instance of class DerivedClass. o is not a Class.
  DerivedClass is a SomeClass of class Class.
  SomeClass is an Object of class Class.
  Class is a Module of class Class. 
  Module is an Object of class Class
  Object is an Object of class Class

   Object (Class) <-- Module (Class) <-- Class (Class)
     /\
     |
  SomeClass (Class) <-- DerivedClass (Class)

            o (DerivedClass)

  In Ruby, everything is an Object, whether it be a base "type", such as Object, Module, Class, SomeClass, or Integer, or an instance of one of those types, such as o. What that means is that all "instance methods" that are defined for Object are also available as instance methods on every class, class instance, or module that is defined in the language, either by you or by Ruby itself. For example, take the nil? method defined on Object:
  eos

  code <<-eos
  Object.nil?
  eos
  # 
  #
  # Any base "type" in Ruby, such as Object, Module, Class, SomeClass, and Integer, is a Class.
  # What this means is that any methods defined on Class are also defined on 

  end
end