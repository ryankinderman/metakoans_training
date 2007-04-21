#!/usr/bin/env ruby
def generate
  puts "#!/usr/bin/env ruby"
  yield
end

def text(string)
  first = true
  tabs = 0
  string.split("\n").each do |line|
    if first
      tab_matches = line.match(/^(\s\s|\t)/)
      tabs = tab_matches.nil? ? 0 : tab_matches.captures.size
      first = false
    end
    line.gsub!(/^(\s\s|\t){#{tabs}}/, '')
    puts "# #{line}"
  end
end

def section_char
  (['#', '=', '-'])[@section_level]
end

def section(name)
  @section_level = @section_level.nil? ? 0 : @section_level + 1
  section_string = <<-eos
#{section_char * 52}
 #{name}
#{section_char * 52}
  eos
  text section_string
  yield
  @section_level -= 1
end

def code(string)
  text string
  begin
    text "Result: #{instance_eval(string)}"
  rescue Exception => e
    text %{#{e.backtrace.shift}: #{e.message}\n\t#{e.backtrace.collect { |e| "from #{e}"}.join("\n")}}
  end
end

generate do
  section "Overview of the Ruby Type Structure" do

  code <<-eos
  class SomeClass
  end
  class DerivedClass < SomeClass
  end
  o = DerivedClass.new
  eos

  text <<-eos

  o is an instance of class DerivedClass. o is not a Class.
  DerivedClass is a SomeClass of class Class.
  SomeClass is an Object of class Class.
  Class is a Module of class Class. 
  Module is an Object of class Class
  Object is an Object of class Class

   Object (Class) <-- Module (Class) <-- Class (Class)
     /\
     |
  SomeClass (Class) <-- DerivedClass (Class)

            o (DerivedClass)

  In Ruby, everything is an Object, whether it be a base "type", such as Object, Module, Class, SomeClass, or Integer, or an instance of one of those types, such as o. What that means is that all "instance methods" that are defined for Object are also available as instance methods on every class, class instance, or module that is defined in the language, either by you or by Ruby itself. For example, take the nil? method defined on Object:

  eos

  code <<-eos
  Object.nil?
  eos
  # 
  #
  # Any base "type" in Ruby, such as Object, Module, Class, SomeClass, and Integer, is a Class.
  # What this means is that any methods defined on Class are also defined on 

  end
end