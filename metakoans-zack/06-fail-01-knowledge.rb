

module Attributable
  
  def attribute attr_name
    # fails koan 6 because attr_name in the if is at the class level
    # try to puts c.send(:instance_variable_get, :@a) to see
    if attr_name.kind_of? Hash
      key = attr_name.keys[0]
      eval("@#{key} = attr_name[key]")
      attr_name = key
    end
    define_method (attr_name + "=").to_sym do |val| eval("@#{attr_name} = val") end
    define_method (attr_name).to_sym do eval("@#{attr_name}") end
    define_method (attr_name + "?").to_sym do eval("@#{attr_name} != nil") end
  end

  
end
 
class Module
  include Attributable
end
  