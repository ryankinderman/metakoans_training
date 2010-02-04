module Attributable
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
    attribute_value = nil
    define_method name do
      default_value = instance_eval &block unless block.nil?
      attribute_value || default_value
    end
    define_method name + "?" do
      !send(name).nil?
    end
    define_method name + "=" do |value|
      attribute_value = value
      default_value = nil
      block = nil
    end
  end
end

class SomeClass
end

class Class
  include Attributable
end