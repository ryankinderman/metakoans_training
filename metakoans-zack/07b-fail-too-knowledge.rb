
module Attributable
  
  private
  
  def attribute attr_name, &block
    block_given = block
    if attr_name.kind_of? Hash
      key = attr_name.keys[0]
      value = attr_name[key]
      attr_name = key
    end
    
    define_method attr_name + "=" do |val|
      value = nil
      block_given = nil
      eval("@#{attr_name} = val")
    end
    
    define_method attr_name do
      return eval("@#{attr_name}") unless value || block_given
      value || instance_eval(block_given.call)

    end
    
    define_method attr_name + "?" do 
      eval("@#{attr_name} != nil") || value || block_given
    end
  end

  
end
 
class Module
  include Attributable
end
  
  