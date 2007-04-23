module MetaKoans
  
class SomeClass
  def self.attribute; end  

  def a?
    !@a.nil?
  end
  
  def a
    @a
  end
  
  def a=(value)
    @a = value
  end
  # def self.attribute(name)
  #   attr_var = "@#{name}"
  # 
  #   define_method(name + "?") do
  #     !instance_variable_get(attr_var).nil?
  #   end
  #   define_method(name + "=") do |value|
  #     instance_variable_set attr_var, value
  #   end
  #   define_method(name) do
  #     instance_variable_get(attr_var)
  #   end
  # end
end

end