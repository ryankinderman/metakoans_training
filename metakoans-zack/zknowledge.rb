

class Module
   private
    
    def attribute attr_name, &block
      if attr_name.kind_of? Hash
        initial_value = attr_name.values[0]
        attr_name = attr_name.keys[0]
      end
      
      attr_var = "@#{attr_name}"

      define_method attr_name do
        if instance_variables.include?(attr_var)
          instance_variable_get(attr_var)
        elsif block_given?
          instance_eval(&block)
        else
          initial_value
        end
      end        

      define_method attr_name + "?" do 
        send(attr_name) != nil
      end
      
      define_method attr_name + "=" do |val|
        instance_variable_set(attr_var, val)
      end
      
    end

end

class Foo
  attribute "bar" => 2
end


f = Foo.new

#puts f.bar
#puts f.bar?
#puts f.bar
#f.bar = 3
#puts f.bar?
#puts f.bar
