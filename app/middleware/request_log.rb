# class RequestLog
#   def initialize(app)
#     @app = app
#   end

#   def call(env)
#     request = ActionDispatch::Request.new(env)
#     start_time = Time.now
#     status, headers, response = @app.call(env)
#     response_time = Time.now -  start_time
#     unless request.path.starts_with?("/assets") || request.path == "/health" || request.path == "/favicon.ico"
#       # Log the request details
#       Log.green("Request URL: #{request.url}")
#       Log.green("Request Method: #{request.request_method}")
#       Log.green("Request Headers: #{request.headers.to_h}")
#       Log.green("Request Parameters: #{request.params.to_h}")
#       Log.green("Request Body: #{request.body.read}")
#       # Rails.logger.info("Request URL: #{request.url}")
#       # Rails.logger.info("Request Method: #{request.request_method}")
#       # Rails.logger.info("Request Headers: #{request.headers.to_h}")
#       # Rails.logger.info("Request Parameters: #{request.params.to_h}")
#       # Rails.logger.info("Request Body: #{request.body.read}")
#       request_method(request, status, response_time)
#     end
#   end

#   private

#   def request_method(request, status, response_time)
#     RequestLogger.create!(
#     path: request.path,
#     user_agent: request.user_agent,
#     ip: request.ip,
#     status: status,
#     response_time: response_time,
#     method: request.request_method,
#     user_id: request.session[:user_id],
#     params: request.params.to_h
#     )
#   rescue => e
#     Log.red("Error logging request: #{e.message}")
#   end
# end
# app/middleware/request_logger.rb
class RequestLog
  def initialize(app)
    @app = app
  end

  def call(env)
    begin
      request = ActionDispatch::Request.new(env.dup)

      start_time = Time.now
      status, headers, response = @app.call(env)
      response_time = Time.now - start_time

      # Skip logging for certain paths
      unless skip_logging?(request)
        log_request(request, status, response_time)
      end

      [ status, headers, response ]
    rescue => e
      Rails.logger.error "RequestLogger error: #{e.message}"
      @app.call(env)
    end
  end

  private

  def skip_logging?(request)
    request.path.start_with?("/assets") ||
    request.path == "/health" ||
    request.path == "/favicon.ico"
  end

  def log_request(request, status, response_time)
    RequestLogger.create!(
      path: request.path,
      method: request.request_method,
      params: safe_params(request),
      ip: request.ip,
      user_agent: request.user_agent,
      user_id: user_id_from_request(request),
      status: status,
      response_time: response_time
    )
  rescue => e
    Rails.logger.error "Failed to log request: #{e.message}"
  end

  def safe_params(request)
    request.filtered_parameters.except("controller", "action").to_json
  rescue
    {}
  end

  def user_id_from_request(request)
    # request.env["warden"]&.user&.id
    request.session[:user_id] || request.session["user_id"]
    Log.blue("user id from request #{request.session[:user_id]}")
  rescue
    nil
  end
end
