module ApiErrors
  class ValidationError < ApiError
    def initialize(details = {})
      @http_code = 422 # Unprocessable Entity
      @id = 'validation_error'
      @developer_message = 'Some fields in the request are incorrect'
      @details = details.is_a?(Hash) ? details : { message: details }
    end
  end
end
