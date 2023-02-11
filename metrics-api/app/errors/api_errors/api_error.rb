module ApiErrors
  class ApiError < StandardError
    attr_reader :http_code, :id, :developer_message, :details

    def as_json(*)
      {
        http_code: http_code,
        id: id,
        developer_message: developer_message,
        details: details
      }
    end
  end
end
