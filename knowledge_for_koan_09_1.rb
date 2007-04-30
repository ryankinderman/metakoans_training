class SomeClass
end

class Module
  def attribute(params='a', &block)
    name, default_value = process_args(params)
    
    define_methods(name, default_value, &block)
  end
  
  private
  
  def process_args(params)
    name = nil
    default_value = nil
    if params.is_a?(Hash)
      name = params.keys[0]
      default_value = params[name]
    else
      name = params
    end
    
    [name, default_value]
  end
  
  def define_methods(name, default_value, &block)
    attribute_name = "@#{name}"
    define_method name + "_default" do
      attribute_assigned = !instance_variable_get(attribute_name + "_assigned").nil?
      return nil if attribute_assigned
      default_value = instance_eval &block unless block.nil?
      default_value
    end
    define_method name do
      instance_variable_get(attribute_name) || send(name + "_default")
    end
    define_method name + "?" do
      !send(name).nil?
    end
    define_method name + "=" do |value|
      instance_variable_set attribute_name, value
      instance_variable_set attribute_name + "_assigned", true
    end
  end
  
  
end