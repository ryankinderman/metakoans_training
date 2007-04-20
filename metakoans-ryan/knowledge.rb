class Module
  def attribute(params, &block)
    initial = nil
    if params.is_a?(Hash)
      name = params.keys[0]
      initial = params.values[0]
    else
      name = params
    end
    
    define_attribute_methods(name, initial, &block)
  end
  
  private
  
  def define_attribute_methods(name, initial_value, &block)
    define_method(name) do
      initial_value ||= instance_eval &block unless !block_given?
      
      instance_eval <<-code
      @#{name}_attr ||= initial_value unless @#{name}_attr_is_set
      @#{name}_attr
      code
    end
    define_method(name + '=') do |value| 
      instance_eval <<-code
      @#{name}_attr = value; 
      @#{name}_attr_is_set = true
      code
    end
    define_method(name + '?') do
      instance_eval <<-code
      !@#{name}_attr.nil?
      code
    end
  end
end
