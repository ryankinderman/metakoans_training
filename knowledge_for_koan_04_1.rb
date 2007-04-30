module Attributable
  def attribute(name='a')
    var_name = "@#{name}"
    define_method name + "?" do
      !instance_variable_get(var_name).nil?
    end
    define_method name + "=" do |value|
      instance_variable_set var_name, value
    end
    define_method name do
      instance_variable_get(var_name)
    end
  end
end

class SomeClass
  extend Attributable
  class << self
    extend Attributable
  end  
end
