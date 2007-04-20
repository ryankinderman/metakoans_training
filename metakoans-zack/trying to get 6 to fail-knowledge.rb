
module Attributable
  
  private
  
  def attribute attr_name
    #hash = {}
    if attr_name.kind_of? Hash
      key = attr_name.keys[0]
      #hash[key] = attr_name[key]
      value = attr_name[key]
      puts value
      attr_name = key
    end
    
    define_method attr_name + "=" do |val|
      #value = nil 
      eval("@#{attr_name} = val")
    end
    
    define_method attr_name do 
      return eval("@#{attr_name}") unless value
      value
    end
    
    define_method attr_name + "?" do 
      eval("@#{attr_name} != nil") || value
    end
  end

  
end
 
class Module
  include Attributable
end
  
  