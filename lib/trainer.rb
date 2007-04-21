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