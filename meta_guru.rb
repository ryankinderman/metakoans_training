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
        when 'koan_1', 'koan_2'
          "learn the rules so you know how to break them properly"
        when 'koan_3', 'koan_4'
          "remember that silence is sometimes the best answer"
        when 'koan_5', 'koan_6'
          "sleep is the best meditation"
        when 'koan_7'
          "when you lose, don't lose the lesson"
        when 'koan_8'
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