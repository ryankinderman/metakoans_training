# And finally, the koan expects that 'a?' does not, in fact, return false all the time!
# Instead, it appears to return 'true' when the variable accessed or altered by 'a' or
# 'a=' has a value.
class SomeClass
  def self.attribute
  end

  def a?
    !@val.nil?
  end

  def a=(value)
    @val = value
  end

  def a
    @val
  end
end
