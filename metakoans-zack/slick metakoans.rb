class Module
  def attribute(name, &block)
    return name.each {|k,v| attribute(k) {v}} if name.is_a? Hash

    at_name = "@#{name}"
    define_method(name) do 
      if instance_variables.include?(at_name)
        instance_variable_get(at_name)
      else
        block_given? ? instance_eval(&block) : nil
      end
    end
    define_method("#{name}=") do |new_value|
      instance_variable_set(at_name, new_value)
    end
    define_method("#{name}?") do 
      !!send(name)
    end
  end
  
end

class Foo
  attribute "bar" => 2
end

f = Foo.new
puts f.bar
puts f.bar?
#puts f.bar
#f.bar = 3
#puts f.bar?
#puts f.bar

