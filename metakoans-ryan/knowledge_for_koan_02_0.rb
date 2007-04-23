module MetaKoans
  
class SomeClass
  def self.attribute(name='a'); end  

  def a?
    !@a.nil?
  end
  
  def a
    @a
  end
  
  def a=(value)
    @a = value
  end
end

end