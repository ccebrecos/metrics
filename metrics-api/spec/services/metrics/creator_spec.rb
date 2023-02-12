require 'rails_helper'

describe Metrics::Creator do
  let(:sut) { described_class.new(create_params: create_params) }

  let(:create_params) do
    {
      name: name,
      value: value,
      valid_at: valid_at
    }.compact
  end

  let(:name) { 'm3' }
  let(:value) { 2.71828 }
  let(:valid_at) { 1.hour.ago }

  describe '#create!' do
    it 'creates a new metric with the given params' do
      sut.create!

      metric = Metric.last

      expect(metric.name).to eq(name)
      expect(metric.value).to eq(value)
      expect(metric.valid_at).to eq(valid_at)
    end

    context 'when a required param is not provided' do
      let(:name) { nil }

      it 'raises not null violation error' do
        expect { sut.create! }.to raise_error(ActiveRecord::NotNullViolation)
      end
    end
  end
end
