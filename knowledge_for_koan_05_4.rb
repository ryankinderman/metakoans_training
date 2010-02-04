module Attributable
  def attribute(params='a')
    name, default_value = process_args(params)

    define_methods(name, default_value)
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
