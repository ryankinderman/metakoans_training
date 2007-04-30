#
# metakoans.rb is an arduous set of exercises designed to stretch
# meta-programming muscle.  the focus is on a single method 'attribute' which
# behaves much like the built-in 'attr', but whose properties require delving
# deep into the depths of meta-ruby.  usage of the 'attribute' method follows
# the general form of
#   
#   class C
#     attribute 'a'
#   end
#   
#   o = C.new
#   o.a = 42  # setter - sets @a
#   o.a       # getter - gets @a 
#   o.a?      # query - true if @a
#   
# but reaches much farther than the standard 'attr' method as you will see
# shortly.
#   
# your path, should you choose to follow it, is to write a single file
# 'knowledge.rb' implementing all functionality required by the koans below.
# as a student of meta-programming your course will be guided by a guru whose
# wisdom and pithy sayings will assist you on your journey.
#   
# a successful student will eventually be able to do this   
#   
#   harp:~ > ruby metakoans.rb knowledge.rb
#   koan_1 has expanded your awareness
#   koan_2 has expanded your awareness
#   koan_3 has expanded your awareness
#   koan_4 has expanded your awareness
#   koan_5 has expanded your awareness
#   koan_6 has expanded your awareness
#   koan_7 has expanded your awareness
#   koan_8 has expanded your awareness
#   koan_9 has expanded your awareness
#   mountains are again merely mountains
#   
require File.dirname(__FILE__) + '/meta_guru'
require File.dirname(__FILE__) + '/meta_student'

# knowledge = ARGV.shift or abort "#{ $0 } knowledge.rb"
student = MetaStudent.new 'knowledge_for_koan_09_1'

module MetaKoans

  #
  # 'attribute' must provide getter, setter, and query for 'a' to instances of SomeClass
  #
  def koan_1
    SomeClass.attribute
    
    o = SomeClass.new

    assert{ not o.a? }
    assert{ o.a = 42 }
    assert{ o.a == 42 }
    assert{ o.a? }
  end

  #
  # the name of the getter, setter, and query methods created by 'attribute' must match
  # the value of the given parameter
  #
  def koan_2
    SomeClass.attribute 'b'
    
    o = SomeClass.new
    
    assert{ not o.b? }
    assert{ o.b = 41 }
    assert{ o.b == 41 }
    assert{ o.b? }
  end
  
  #
  # multiple calls to 'attribute' with different parameter values must generate multiple
  # methods whose names correspond to the parameter value, and whose values must must be
  # independent of each other
  #
  # this koan also illustrates how calling 'attribute' through SomeClass.class_eval 
  # has the same effect as calling 'attribute' directly on SomeClass.
  #
  # additionally, by virtue of the fact that 'attribute' is available and working on
  # SomeClass, creating an attribute on an object-specific class should automatically
  # work
  #
  def koan_3
    SomeClass.attribute 'c'
    
    o = SomeClass.new
    
    assert{ not o.c? }
    assert{ o.c = 39 }
    assert{ o.c == 39 }
    assert{ o.c? }
  
    SomeClass.class_eval { attribute 'd' }
    
    assert{ not o.d? }
    assert{ o.d = 38 }
    assert{ o.d == 38 }
    assert{ o.d? }
    
    class << o
      attribute 'e'
    end
    
    assert{ not o.e? }
    assert{ o.e = 37 }
    assert{ o.e == 37 }
    assert{ o.e? }                
  end
  
  #
  # 'attribute' must be callable from the singleton class of SomeClass, and must
  # generate corresponding getter, setter, and query methods on the class itself
  # in addition to instances of it.
  #
  def koan_4
    SomeClass.class_eval do
      class << self
        attribute 'f'
        attribute 'g'
      end
    end
    
    assert{ not SomeClass.f? }
    assert{ SomeClass.f = 36 }
    assert{ SomeClass.f == 36 }
    assert{ SomeClass.f? }        
  
    assert{ not SomeClass.g? }
    assert{ SomeClass.g = 35 }
    assert{ SomeClass.g == 35 }
    assert{ SomeClass.g? }        
  end
  
  #
  # 'attribute' must provide a method for providing a default value as hash
  #
  def koan_5
    SomeClass.class_eval do
      attribute 'h' => 34
      attribute 'i' => 33
    end
    
    o = SomeClass.new

    assert{ o.h == 34 }
    assert{ o.h? }
    assert{ (o.h = nil).nil? }
    assert{ o.h == nil }
    assert{ not o.h? }

    assert{ o.i == 33 }
    assert{ o.i? }
    assert{ (o.i = nil).nil? }
    assert{ o.i == nil }
    assert{ not o.i? }
  end
  
  #
  # 'attribute' must provide a method for providing a default value as block
  # which is evaluated at instance level
  #
  # instance_eval is called to define an attribute in order to illustrate the 
  # difference between it and class_eval. this code should not affect your 
  # mastery of this koan
  #
  def koan_6
    SomeClass.class_eval do
      attribute('j'){ thirtytwo }
      attribute('k'){ j - 1 }
      def thirtytwo
        32
      end
    end

    o = SomeClass.new

    assert{ o.j == 32 }
    assert{ o.j? }
    assert{ (o.j = nil).nil? }
    assert{ o.j == nil }
    assert{ not o.j? } 

    o.j = 32
    assert{ o.k == 31 }
    assert{ o.k? }
    assert{ (o.k = nil).nil? }
    assert{ o.k == nil }
    assert{ not o.k? }
    
    SomeClass.instance_eval do
      class << self
        attribute('l'){ thirtyone }
      end
      def thirtyone
        31
      end
    end
    
    assert{ SomeClass.thirtyone == 31 }  
    assert{ SomeClass.l == 31 }
    assert{ SomeClass.l? }
    assert{ (SomeClass.l = nil).nil? }
    assert{ SomeClass.l == nil }
    assert{ not SomeClass.l? }
  end
  
  #
  # 'attribute' must be available to any class
  #
  def koan_7
    c = Class.new do
      class << self
        attribute 'm'
      end
      attribute 'n'
    end
  
    assert{ not c.m? }
    assert{ c.m = 30 }
    assert{ c.m == 30 }
    assert{ c.m? }
  
    o = c.new
  
    assert{ not o.n? }
    assert{ o.n = 29 }
    assert{ o.n == 29 }
    assert{ o.n? }
  end

  #
  # 'attribute' must be available to any module
  #
  def koan_8
    m = Module.new do
      attribute 'o'
    end
    
    c = Class.new do
      include m
      extend m
    end
  
    assert{ not c.o? }
    assert{ c.o = 28 }
    assert{ c.o == 28 }
    assert{ c.o? }
  
    o = c.new
  
    assert{ not o.o? }
    assert{ o.o = 27 }
    assert{ o.o == 27 }
    assert{ o.o? }
  end

  #
  # into the void 
  #
  def koan_9
    b = Class.new {
      class << self
        attribute 'a' => 48
        attribute('b'){ a + 1 }
      end
      include Module.new {
        attribute 'a' => 50
        attribute('b'){ a + 1 }
      }
    }

    c = Class.new b

    assert{ c.a == 48 }
    assert{ c.a? }
    assert{ c.a = 'forty-two' }
    assert{ c.a == 'forty-two' }
    assert{ b.a == 48 }
    c.a = 48

    assert{ c.b == 49 }
    assert{ c.b? }
    assert{ c.b = 'forty-two' }
    assert{ c.b == 'forty-two' }
    assert{ b.b == 49 }

    o = c.new

    assert{ o.a == 50 }
    assert{ o.a? }
    assert{ o.a = nil; o.a == nil }
    assert{ not o.a? }
    o.a = 50

    assert{ o.b == 51 }
    assert{ o.b? }
    assert{ o.b = nil; o.b == nil }
    assert{ not o.b? }
  end

  def assert() 
    bool = yield
    raise StandardError, "assert{ #{ caller.first[%r/^.*(?=:)/] } } #=> #{ bool.inspect }" unless bool 
    bool
  end
end

MetaGuru.enlighten student
