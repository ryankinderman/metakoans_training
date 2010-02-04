# Koan 2 required that the attribute method only need support atomic and exclusive
# interaction with any defined attribute. Now we see that multiple attributes can
# exist at once, and each needs its own state.
#
# The problem was that we were using a single instance variable ('@val') to hold
# the value for all defined attributes. Now we need to use a different instance
# variable for each attribute.
#
# 'instance_variable_get' and 'instance_variable_set' allow us to get/set an
# instance variable with a string whose value is equal to the name of the
# instance variable, including its leading '@'.
class SomeClass

  def self.attribute(name='a')
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
