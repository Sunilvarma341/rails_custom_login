class HomeController < ApplicationController
  def index
  end

  def async_action
    HelloJob.perform_at(10.seconds.from_now)
  end
end
