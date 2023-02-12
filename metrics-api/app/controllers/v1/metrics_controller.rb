module V1
  class MetricsController < ApplicationController
    def index
      validated_params = V1::Metrics::IndexContract.validate!(params.to_unsafe_h)

      name = validated_params[:name]
      grouping = validated_params[:grouping] && ActiveSupport::Duration.parse(validated_params[:grouping])

      @metrics = ::Metrics::Getter.new(name: name, grouping: grouping).get
    end

    def create
      validated_params = V1::Metrics::CreateContract.validate!(params.to_unsafe_h)

      @metric = ::Metrics::Creator.new(
        create_params: validated_params[:metric]
      ).create!

      render('v1/metrics/create', status: :created)
    end
  end
end
