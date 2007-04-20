class Class
  def attribute(name)
    attr_var = "@#{name}_attr"

    define_method(name + "?") do
      !instance_variable_get(attr_var).nil?
    end
    define_method(name + "=") do |value|
      instance_variable_set attr_var, value
    end
    define_method(name) do
      instance_variable_get(attr_var)
    end
  end
end