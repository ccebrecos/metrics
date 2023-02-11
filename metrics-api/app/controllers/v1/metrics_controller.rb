module V1
  class MetricsController < ApplicationController
    def index
      validated_params = V1::Metrics::IndexContract.validate!(params.to_unsafe_h)

      name = validated_params[:name]
      grouping = validated_params[:grouping] && ActiveSupport::Duration.parse(validated_params[:grouping])

      @metrics = ::Metrics::Getter.new(name: name, grouping: grouping).get
    end
  end
end
