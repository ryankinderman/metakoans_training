
module Attributable
  
  def attribute attr_name
    if attr_name.kind_of? Hash
      hash = attr_name
      attr_name = hash.keys[0]
    end
    
    define_method (attr_name + "=").to_sym do |val| eval("@#{attr_name} = val") end
    define_method (attr_name).to_sym do eval("@#{attr_name}") end
    define_method (attr_name + "?").to_sym do eval("@#{attr_name} != nil") end
  end

  
end
 
class Module
  extend Attributable # fails 4 because not available at Module.self level
end