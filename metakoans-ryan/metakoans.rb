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
class MetaStudent
  def initialize knowledge
    require knowledge
  end
  def ponder koan
    begin
      send koan
      true
    rescue => e
      STDERR.puts %Q[#{ e.message } (#{ e.class })\n#{ e.backtrace.join 10.chr }]
      false
    end
  end
end


class MetaGuru
  require "singleton"
  include Singleton

  def enlighten student
    student.extend MetaKoans

    koans = student.methods.grep(%r/koan/).sort

    attainment = nil

    koans.each do |koan| 
      awakened = student.ponder koan
      if awakened
        puts "#{ koan } has expanded your awareness"
        attainment = koan
      else
        puts "#{ koan } still requires meditation"
        break
      end
    end

    puts(
      case attainment
        when nil 
          "mountains are merely mountains"
        when 'koan_1', 'koan_2', 'koan_01', 'koan_02'
          "learn the rules so you know how to break them properly"
        when 'koan_3', 'koan_4', 'koan_03', 'koan_04'
          "remember that silence is sometimes the best answer"
        when 'koan_5', 'koan_6', 'koan_05', 'koan_06'
          "sleep is the best meditation"
        when 'koan_7', 'koan_07'
          "when you lose, don't lose the lesson"
        when 'koan_8', 'koan_08'
          "things are not what they appear to be: nor are they otherwise"
        else
          "mountains are again merely mountains"
      end
    )
  end
  def self::method_missing m, *a, &b
    instance.send m, *a, &b
  end
end


# knowledge = ARGV.shift or abort "#{ $0 } knowledge.rb"
student = MetaStudent.new 'knowledge_for_koan_06_1'


module MetaKoans

  #
  # 'attribute' must provide getter, setter, and query for 'a' to instances of SomeClass
  #
  def koan_01
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
  def koan_02
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
  # this koan also illustrates how calling 'attribute' through SomeClass.instance_eval 
  # has the same effect as calling 'attribute' directly on SomeClass.
  #
  # additionally, by virtue of the fact that 'attribute' is available and working on
  # SomeClass, creating an attribute on an object-specific class should automatically
  # work
  #
  def koan_03
    SomeClass.attribute 'c'
    
    o = SomeClass.new
    
    assert{ not o.c? }
    assert{ o.c = 39 }
    assert{ o.c == 39 }
    assert{ o.c? }
  
    SomeClass.instance_eval { attribute 'd' }
    
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
  def koan_04
    SomeClass.instance_eval do
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
  def koan_05
    SomeClass.instance_eval do
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
  def koan_06
    SomeClass.instance_eval do
      attribute('j'){ fortythree }
      def fortythree
        32
      end
    end

    o = SomeClass.new

    assert{ o.j == 32 }
    assert{ o.j? }
    assert{ (o.j = nil).nil? }
    assert{ o.j == nil }
    assert{ not o.j? }
  end
  

#
# 'attribute' must provide getter, setter, and query to instances
#
  def koan_1
    c = Class.new {
      attribute 'a'
    }

    o = c.new

    assert{ not o.a? }
    assert{ o.a = 42 }
    assert{ o.a == 42 }
    assert{ o.a? }
  end
#
# 'attribute' must provide getter, setter, and query to classes 
#
  def koan_2
    c = Class.new {
      class << self
        attribute 'a'
      end
    }

    assert{ not c.a? }
    assert{ c.a = 42 }
    assert{ c.a == 42 }
    assert{ c.a? }
  end
#
# 'attribute' must provide getter, setter, and query to modules at module
# level
#
  def koan_3
    m = Module.new {
      class << self
        attribute 'a'
      end
    }

    assert{ not m.a? }
    assert{ m.a = 42 }
    assert{ m.a == 42 }
    assert{ m.a? }
  end
#
# 'attribute' must provide getter, setter, and query to modules which operate
# correctly when they are included by or extend objects
#
  def koan_4
    m = Module.new {
      attribute 'a'
    }

    c = Class.new {
      include m
      extend m
    }

    o = c.new

    assert{ not o.a? }
    assert{ o.a = 42 }
    assert{ o.a == 42 }
    assert{ o.a? }

    assert{ not c.a? }
    assert{ c.a = 42 }
    assert{ c.a == 42 }
    assert{ c.a? }
  end
#
# 'attribute' must provide getter, setter, and query to singleton objects 
#
  def koan_5
    o = Object.new

    class << o
      attribute 'a'
    end

    assert{ not o.a? }
    assert{ o.a = 42 }
    assert{ o.a == 42 }
    assert{ o.a? }
  end
#
# 'attribute' must provide a method for providing a default value as hash
#
  def koan_6
    c = Class.new {
      attribute 'a' => 42
    }

    o = c.new

    assert{ o.a == 42 }
    assert{ o.a? }
    assert{ o.a = nil; o.a == nil }
    assert{ not o.a? }
  end
#
# 'attribute' must provide a method for providing a default value as block
# which is evaluated at instance level 
#
  def koan_7
    c = Class.new {
      attribute('a'){ fortythree }
      def fortythree
        43
      end
    }

    o = c.new

    assert{ o.a == 43 }
    assert{ o.a? }
    assert{ o.a = nil; o.a == nil }
    assert{ not o.a? }
  end
#
# 'attribute' must provide inheritance of default values at both class and
# instance levels
#
  def koan_8
    b = Class.new {
      class << self
        attribute 'a' => 44
        attribute('b'){ a + 1 }
      end
      attribute 'a' => 46
      attribute('b'){ a + 1 }
    }

    c = Class.new b

    assert{ c.a == 44 }
    assert{ c.a? }
    assert{ c.a = nil; c.a == nil }
    assert{ not c.a? }
    c.a = 44

    assert{ c.b == 45 }
    assert{ c.b? }
    assert{ c.b = nil; c.b == nil }
    assert{ not c.b? }

    o = c.new

    assert{ o.a == 46 }
    assert{ o.a? }
    assert{ o.a = nil; o.a == nil }
    assert{ not o.a? }
    o.a = 46
    
    assert{ o.b == 47 }
    assert{ o.b? }
    assert{ o.b = nil; o.b == nil }
    assert{ not o.b? }
    
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
