
module Attributable
  
  private
  
  def attribute attr_name
    hash = {}
    if attr_name.kind_of? Hash
      key = attr_name.keys[0]
      hash[key] = attr_name[key]
      attr_name = key
    end
    
    define_method attr_name + "=" do |val|
      hash[attr_name] = nil 
      eval("@#{attr_name} = val")
    end
    
    define_method attr_name do 
      return eval("@#{attr_name}") unless hash[attr_name]
      hash[attr_name]
    end
    
    define_method attr_name + "?" do 
      eval("@#{attr_name} != nil") || hash[attr_name]
    end
  end

  
end
 
class Module
  include Attributable
end
  
  