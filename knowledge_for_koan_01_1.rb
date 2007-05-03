# The method being called on SomeClass is called 'attribute'. Next, a method
# called 'a?' is called. We'll just go ahead and define those two methods.
#
# 'attribute' is a "class" method, and 'a?' is an "instance" method.
class SomeClass
  def self.attribute
  end
  
  def a?
    false
  end
end
