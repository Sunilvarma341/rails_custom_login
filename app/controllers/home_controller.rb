require "concurrent"

class HomeController < ApplicationController
  def index
  end

  def async_action
   # HelloJob.perform_at(10.seconds.from_now)
   # ReccuringMeetingsJob.perform_async()
   #  HomeHelper.start_time_intervel(2)
   #  sleep(5)
   #  HomeHelper.stop_time_intervel
   Log.blue("root dir  #{Dir[Rails.root.join("lib")]}   #{__dir__}")
   Log.green("file expande path #{File.expand_path("../Gemfile", __dir__)
   }")
  end
end
