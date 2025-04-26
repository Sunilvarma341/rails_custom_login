namespace :request_logs do
  desc "Fextch and display the request Logs"
  task :requests, [ :limit ] => :environment do |t, arg |
    limit = arg[:limit] || 10
    request_logger =  RequestLogger.limit(limit).order(created_at: :desc)

    request_logger.each do |log|
      green([
        request_logger.created_at.strftime("%Y-%m-%d %H:%M:%S"),
        request_logger.path,
        request_logger.user_agent,
        request_logger.ip,
        request_logger.status,
        request_logger.response_time,
        request_logger.request_method,
        request_logger.user_id,
        request_logger.params.to_h

    ].join("|"))
    end
  end
end
