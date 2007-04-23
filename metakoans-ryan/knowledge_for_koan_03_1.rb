module MetaKoans

module Attributable
  def attribute(name='a')
    define_method name + "?" do
      !@val.nil?
    end
    define_method name + "=" do |value|
      @val = value
    end
    define_method name do
      @val
    end
  end
end

class SomeClass
  extend Attributable
  class << self
    extend Attributable
  end  
end

end