# class << self opens up the "singleton class" of 'SomeClass'. Every object in
# Ruby can have a singleton class, but only one (hence the name). The first time
# that it's opened up or otherwise-referenced, it gets created for the object 
# that it was referenced through (its owner). When the singleton class is 
# created, the class of the singleton class's owner becomes the superclass of the 
# singleton class and the singleton class becomes the new class of the owner.
#
# Singleton classes in Ruby are given special treatment, in that instance methods
# that are defined for them are class methods of the singleton class's owning class.
#
# Koan 4 is calling 'attribute' from within the context of the singleton class.
# This is not to be confused with calling 'self.attribute' from within the
# context of 'SomeClass', which calls the 'attribute' method defined on SomeClass.
# The general syntax for opening up the singleton class of any object is:
#
# any_object = Object.new
# class << any_object
# ...
# end
#
# In Ruby, 'self' always refers to the object that the code is currently 
# executing within (aka the code's "context"). So, whereas 'self.bleargh' calls 
# the method named 'bleargh' that is defined on the object that the code is 
# currently executing within, 'class << self' opens up the singleton class of 
# the object referred to by 'self'.
#
# I hope this isn't completely confusing.
class SomeClass

  class << self
    def self.attribute(name='a')
      var_name = "@#{name}"
      define_method name + "?" do
        !instance_variable_get(var_name).nil?
      end
      define_method name + "=" do |value|
        instance_variable_set var_name, value
      end
      define_method name do
        instance_variable_get(var_name)
      end
    end
  end
  
  def self.attribute(name='a')
    var_name = "@#{name}"
    define_method name + "?" do
      !instance_variable_get(var_name).nil?
    end
    define_method name + "=" do |value|
      instance_variable_set var_name, value
    end
    define_method name do
      instance_variable_get(var_name)
    end
  end
  
end
