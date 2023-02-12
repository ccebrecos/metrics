module V1::Metrics
  class CreateContract < ApplicationContract
    params do
      required(:metric).hash do
        required(:name).filled(:string)
        required(:value).filled(:float)
        required(:valid_at).filled(:string)
      end
    end

    rule(metric: :valid_at) do
      next unless key?
      key.failure('Invalid valid_at format; expected iso8601') unless iso8601?(value)
    end

    private

    def iso8601?(value)
      DateTime.iso8601(value)
      true
    rescue ArgumentError
      false
    end
  end
end
