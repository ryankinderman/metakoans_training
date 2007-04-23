module MetaKoans
  
class SomeClass
  class << self
    def self.attribute(name='a')
      attr_accessor name
      define_method name + "?" do
        !send(name).nil?
      end
    end      
  end
  
  def self.attribute(name='a')
    attr_accessor name
    define_method name + "?" do
      !send(name).nil?
    end
  end  
end

end