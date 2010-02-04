# Well, it looks like we actually have to do something in the 'attribute' method
# now! Now it has to be able to define getter, setter, and query methods with
# arbitrary names.
#
# We do this by moving the logic for each of the 'a' methods into a block passed
# into a call to 'define_method', which defines an instance method whose name is
# equal to the string value passed in as the first argument, and whose body is
# the block passed in as the second.
#
# While it may not look like it, the do..end following the first argument to
# 'define_method' is actually the second argument, which creates a code block
# that is passed as the last parameter. No comma separator is needed with this
# syntax. Another way of doing the same thing looks like:
#
# block = Proc.new { !@val.nil? }
# define_method name + "?", &block
#
# The '&' in front of the variable name tells Ruby to convert the Proc instance
# as a block. Blocks in Ruby can only ever be specified as the last argument to
# a method, in either the converted-Proc, do..end, or {} form.
#
# The second call to 'define_method' creates the setter method for the attribute.
# The '|value|' following the 'do' is how you create a block that takes arguments.
# Each name specified between the '|'s is a variable that must get passed in when
# the block is executed. Each argument is separated by a comma.
class SomeClass

  def self.attribute(name='a')
    define_method name + "?" do
      !@val.nil?
    end
    define_method name + "=" do |value|
      @val = value
    end
    define_method name do
      @val
    end
  end

end
