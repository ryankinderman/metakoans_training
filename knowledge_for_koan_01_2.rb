# Next, the koan calls:
#   SomeClass.a = value
# This appears to be a simple assignment statement, but is in fact a method call.
# In Java, the practice for setting the value on an object is to call a method with
# a name like 'set_field'. In .NET, you can use "properties". In Ruby, it's just 
# another method with assignment symantics.
class SomeClass
  def self.attribute
  end
  
  def a?
    false
  end
  
  def a=(value)
    @val = value
  end
end
