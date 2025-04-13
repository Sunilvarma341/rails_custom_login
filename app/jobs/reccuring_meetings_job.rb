# class ReccuringMeetingsJob < ApplicationJob
#   queue_as :cron

#   # # Retry configuration should be at class level, not inside perform
#   retry_on ActiveRecord::RecordNotFound, wait: :exponentially_longer, attempts: 3

#   def perform(*args)
#     Rails.logger.info "Starting reccuring meeting #{Time.now}"
#     # Do something later
#     puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ #{Time.now}".colorize(color: :green, mode: :bold)
#   rescue StandardError => e
#     # Handle other errors if needed
#     Rails.logger.error "Error in ReccurringMeetingsJob: #{e.message}"
#     raise # Re-raise to allow ActiveJob retry mechanism to work
#   end
# end


class ReccuringMeetingsJob
  include Sidekiq::Worker
  sidekiq_options queue: "cron", retry: 3

  def perform(*args)
    Rails.logger.info "Starting recurring meeting #{Time.now}"
    puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ #{Time.now}".colorize(color: :green, mode: :bold)
  rescue StandardError => e
    Rails.logger.error "Error in ReccuringMeetingsJob: #{e.message}"
    raise
  end
end
