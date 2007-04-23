module MetaKoans

module Attributable
  def attribute(name='a')
    attr_accessor name
    define_method name + "?" do
      !send(name).nil?
    end
  end        
end

class SomeClass
  class << self
    extend Attributable
  end
  extend Attributable
end

end