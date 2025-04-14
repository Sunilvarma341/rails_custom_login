
module HomeHelper
  @time_intervel =  nil

  def self.start_time_intervel(delay)
    stop_time_intervel if  thread_running?
   @time_intervel =  Thread.new do
      sleep(delay)
      Log.green("time intervel started #{delay}")
    end
  end

  def self.stop_time_intervel
    if @time_intervel&.alive?
      @time_intervel.kill
      Log.green("Thread stopped")
    end
    @time_intervel = nil
  end

  def self.thread_running?
    @time_intervel&.alive? || false
  end
end
