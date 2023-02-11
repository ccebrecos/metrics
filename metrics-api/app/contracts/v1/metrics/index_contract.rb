module V1::Metrics
  class IndexContract < ApplicationContract
    params do
      required(:name).filled(:string)
      optional(:grouping).filled(:string)
    end

    rule(:grouping) do
      next unless key?
      key.failure('Invalid duration format') unless iso8601_duration?(value)
    end

    private

    def iso8601_duration?(value)
      ActiveSupport::Duration.parse(value)
      true
    rescue ActiveSupport::Duration::ISO8601Parser::ParsingError
      false
    end
  end
end
