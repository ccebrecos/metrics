module Metrics
  class Getter
    # @return [String]
    attr_reader :name

    # @return [String]
    attr_reader :grouping

    # @param [String] name
    # @param [ActiveSupport::Duration, nil] grouping
    def initialize(name:, grouping: nil)
      @name = name
      @grouping = grouping
    end

    def get
      Metric.where(name: name).
        group_by_minute(:valid_at, n: grouping_in_minutes, series: false, format: '%FT%T.%3NZ').
        average(:value).map do |valid_at, avg|
        Metric.new(
          name: name,
          valid_at: valid_at,
          value: avg,
        )
      end
    end

    private

    def grouping_in_minutes
      @grouping_in_minutes ||= grouping.nil? ? 1 : grouping.in_minutes.to_i
    end
  end
end
