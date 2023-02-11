module ApiErrors
  class ResourceNotFoundError < ApiError
    def initialize(details = {})
      @http_code = 404 # Resource not found
      @id = 'resource_not_found'
      @developer_message = 'Some resource was not found. Check all the ids or urls'
      @details = details.is_a?(Hash) ? details : { message: details }
    end
  end
end
