class Class
  def attribute(name)
    define_method(name + "?") do
      false
    end
    define_method(name + "=") do |value|
      instance_variable_set "@#{name}_attr", value
    end
    define_method(name) do
      instance_variable_get("@#{name}_attr")
    end
  end
end