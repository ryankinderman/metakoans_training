
module Attributable
  
  private
  
  def attribute attr_name
    
    define_method attr_name + "=" do |val| 
      eval("@#{attr_name} = val")
    end
    
    define_method attr_name do 
      eval("@#{attr_name}")
    end
    
    define_method attr_name + "?" do 
      eval("@#{attr_name} != nil")
    end
  end

  
end
 
class Module
  include Attributable
end
