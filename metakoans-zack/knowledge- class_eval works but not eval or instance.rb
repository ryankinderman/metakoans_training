
  
  
  module Attributable
    
    private
    
    def self.attribute name
      class_eval %{
        def #{name}
          @#{name}
        end}
        
       class_eval %{
        def #{name}=(value)
          @#{name} = value
        end
       }
      class_eval %{
        def #{name}?
          @#{name} != nil
        end}
       
       
    end
    
    
  end
   
  class Module
    include Attributable
  end
    
  