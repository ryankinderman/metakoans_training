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
