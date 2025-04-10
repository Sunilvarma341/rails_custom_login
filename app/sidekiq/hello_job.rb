class HelloJob
  include Sidekiq::Job

  def perform(*args)
   puts "hello world!"
  end

  def cron_func(name, count)
    puts "Hello #{name}! This is job ##{count} running at #{Time.now}"
  end
end
