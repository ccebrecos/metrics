require 'rails_helper'

describe Metrics::Getter do
  let(:sut) { described_class.new(name: given_name, grouping: grouping) }

  let(:given_name) { existing_name }
  let(:existing_name) { 'm0' }
  let(:grouping) { nil }

  describe '#get' do
    before do
      (1..10).map do |i|
        create(:metric, name: existing_name, valid_at: i.minute.ago)
      end
    end

    it 'returns the proper metrics with the default grouping' do
      result = sut.get

      expect(result.length).to eq(10)
    end

    it 'returns the proper metrics sorted by valid_at' do
      result = sut.get

      expect(result).to eq(result.sort_by(&:valid_at))
    end

    context 'when no metric with that name' do
      let(:given_name) { 'm1' }

      it 'returns empty list' do
        result = sut.get

        expect(result).to match_array([])
      end
    end

    context 'when a grouping is provided' do
      let(:grouping) { ActiveSupport::Duration.parse('P1D') }

      it 'returns the proper metrics respecting given grouping' do
        result = sut.get

        expect(result.length).to eq(1)
      end
    end
  end
end
