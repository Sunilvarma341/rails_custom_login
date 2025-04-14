module ApplicationHelper
  def blue(t)
    puts "#{t}".colorize(:blue)
  end

  def red(t)
    puts "#{t}".colorize(:red)
  end

  def green(t)
    puts "#{t}", colorize(:green)
  end
end
