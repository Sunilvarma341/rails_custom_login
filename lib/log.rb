module Log
  class << self
    def green(v)
      puts "#{v}".colorize(:green)
    end

    def blue(v)
      puts "#{v}".colorize(:blue)
    end

    def red(v)
      puts "#{v}".colorize(:red)
    end
  end
end
