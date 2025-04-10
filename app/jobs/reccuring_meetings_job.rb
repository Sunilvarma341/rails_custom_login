class ReccuringMeetingsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ #{Time.now}"
    retry_on ActiveRecord::RecordNotFound,  wait: :exponentially_longer,  attempts: 3
  end
end
