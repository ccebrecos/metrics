module Metrics
  class Creator
    # @return[Hash]
    attr_reader :create_params

    # @param [Hash] create_params
    def initialize(create_params:)
      @create_params = create_params
    end

    # @return [Array<Metric>, Metric]
    def create!
      Metric.create!(create_params)
    end
  end
end
