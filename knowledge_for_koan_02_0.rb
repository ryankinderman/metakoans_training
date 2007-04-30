module MetaKoans
  
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

end