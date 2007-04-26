module MetaKoans

module Attributable
  def attribute(params='a')
    name = nil
    default_value = nil
    if params.is_a?(Hash)
      name = params.keys[0]
      default_value = params[name]
    else
      name = params
    end
    
    define_methods(name, default_value)
  end
  
  private
  
  def define_methods(name, default_value)
    var_name = "@#{name}"
    define_method name do
      instance_variable_get(var_name) || default_value
    end
    define_method name + "?" do
      !send(name).nil?
    end
    define_method name + "=" do |value|
      instance_variable_set var_name, value
      default_value = nil
    end
  end
end

class SomeClass
  extend Attributable
  class << self
    extend Attributable
  end  
end

end