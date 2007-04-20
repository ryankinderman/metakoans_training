class Class
  def attribute(name)
    define_method(name + "?") do
      false
    end
  end
end