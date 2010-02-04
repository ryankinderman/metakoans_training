class SomeClass
end

class Module
  def attribute(params='a', &block)
    name, default_value = process_args(params)
    
    value = default_value
    attribute_assigned = false
    
    define_method(name) do
      unless value
        if attribute_assigned or block.nil?
          nil
        else
          instance_eval &block
        end
      else
        value
      end
    end
    define_method(name + "?") { !send(name).nil? }
    define_method(name + "=") { |new_value| value = new_value; attribute_assigned = true }
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
  
end