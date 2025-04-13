# require "sidekiq"
# require "sidekiq-cron"

# puts ">>> sidekiq initializer loaded #{File.exist?("config/schedule.yml")}"

# Sidekiq.configure_server do |config|
#   schedule_file = "config/schedule.yml"

#   if File.exist?(schedule_file)
#     puts ">>> Loading Sidekiq schedule file".colorize(:green)
#     Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
#   else
#     puts "!!! Schedule file not found".colorize(:red)
#   end
# end
require "sidekiq"
require "sidekiq-scheduler"

Sidekiq.configure_server do |config|
  schedule_file = Rails.root.join("config", "schedule.yml")
  puts "schedule_fileschedule_fileschedule_file #{schedule_file}".colorize(:red)
  if File.exist?(schedule_file)
    begin
      config.on(:startup) do
        Sidekiq::Scheduler.dynamic = true
        Sidekiq.schedule = YAML.load_file(schedule_file)
        Sidekiq::Scheduler.reload_schedule!
      end
    rescue => e
      Rails.logger.error "Failed to load Sidekiq schedule: #{e.message}"
    end
  end
end
