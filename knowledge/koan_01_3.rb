# Now the koan is calling a method named 'a' and ensuring that its
# value is equal to the value just passed to the field setter whose
# name is 'a='. Lets make that happen.
class SomeClass
  def self.attribute
  end

  def a?
    false
  end

  def a=(value)
    @val = value
  end

  def a
    @val
  end
end
