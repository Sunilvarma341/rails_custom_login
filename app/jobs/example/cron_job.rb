class Example::CronJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts "cron job excecuted at #{Time.now}"
  end
end
