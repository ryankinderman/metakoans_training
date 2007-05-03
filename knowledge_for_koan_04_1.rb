# Koan 2 required that the attribute method only need support atomic and exclusive

# We certainly don't want to leave repeated code around, so this is a refactoring
# of the earlier solution. We've moved the 'attribute' method into a module.
# Modules are often used in Ruby as a way to reuse code without the restrictions
# of inheritance or extra work of delegation.
#
# Modules have the same symantics that classes have, with the exception that
# you cannot create an instance of a module. So, you might be wondering: If
# you can't create an instance of a module, how do you call the instance 
# methods defined in one? This gets us back to the issue of code reuse.
#
# There are two ways to use a module as a method for code reuse across classes.
# The first, and more-commonly-used method is "including" the module inside the
# class. When you 'include' the module in a class, its instance methods and
# variables become the including class's instance methods and variables, and 
# its class methods and variables become the including class's class methods and
# variables. Note that 'include' only works for modules and classes.
#
# The second method of reusing code defined in a module is through "extending"
# an object. When you 'extend' an object with a given module, you add the
# methods of that module to the object. Unlike 'include', 'extend' can be
# called on any object in Ruby. It's how you add behavior to an instance of
# a class, instead of to the class itself. 
#
# 'extend' adds all of the methods defined in the given module to the object on 
# which it's called. If 'extend' is called on a class, the instance methods
# defined in the module become class methods of the class. This is because
# what's actually happening is they are becoming instance methods of the
# particular instance of the 'Class' class called, in this case, 'SomeClass'.
# The same thing is happening to 'SomeClass''s singleton class.
#
# Yes, there is a 'Class' class, and 'SomeClass' is an instance of it, and both
# are Objects (capital 'O').
module Attributable
  def attribute(name='a')
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

class SomeClass
  extend Attributable
  class << self
    extend Attributable
  end  
end
