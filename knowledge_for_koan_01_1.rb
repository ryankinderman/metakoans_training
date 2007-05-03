# The method being called on SomeClass is called 'attribute'. Next, a method
# called 'a?' is called. We'll just go ahead and define those two methods.
#
# The 'self.' in front of 'attribute' defines it as a "class" method, whereas
# 'a?' is an "instance" method.
class SomeClass
  def self.attribute
  end
  
  def a?
    false
  end
end
