class ApplicationController < ActionController::API
  rescue_from StandardError, with: :standard_error_handler

  def standard_error_handler(err)
    err = ApiErrors::ResourceNotFoundError.new(err.message) if err.is_a?(ActiveRecord::RecordNotFound)

    unless err.is_a?(ApiErrors::ApiError)
      details = {
        exception: err.class.to_s,
        message: err.message,
        app_traces: Rails.backtrace_cleaner.clean(err.backtrace),
      }

      err = ApiErrors::GenericError.new(details)
    end

    render_api_error(err)
  end

  def render_api_error(api_err)
    render json: { error: api_err }, status: api_err.http_code
  end
end
