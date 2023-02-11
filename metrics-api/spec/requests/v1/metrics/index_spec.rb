require 'rails_helper'

describe 'GET v1/metrics', type: :request do
  let(:url) { v1_metrics_url }

  let(:params) do
    {
      name: asked_name,
      grouping: grouping,
    }.compact
  end

  let(:asked_name) { existing_name }
  let(:existing_name) { 'm0' }
  let(:grouping) { nil }

  let!(:expected_metrics) do
    (1..10).map do |i|
      create(:metric, name: existing_name, valid_at: i.minute.ago)
    end
  end

  let(:mock_metrics_getter) { instance_double(Metrics::Getter, get: expected_metrics) }

  before do
    allow(Metrics::Getter).to receive(:new).and_return(mock_metrics_getter)
  end

  let(:body_response) { response.parsed_body.with_indifferent_access }

  context 'when success' do
    it 'returns status code 200 and a list of metrics with the default grouping' do
      get(url, params: params)

      expect(response).to have_http_status(200)
      expect(body_response[:metrics].count).to eq(expected_metrics.count)
    end
  end

  context 'when a grouping is provided' do
    let(:grouping) { 'PT5M' }

    it 'returns status code 200 and a list of metrics with the proper grouping' do
      get(url, params: params)

      expect(response).to have_http_status(200)
      expect(body_response[:metrics].count).to eq(expected_metrics.count)
    end
  end

  context 'when name a required param is not provided' do
    let(:asked_name) { nil }

    it 'returns status code 422 with custom validation error' do
      get(url, params: params)

      expect(response).to have_http_status(422)
      expect(body_response[:error][:id]).to eq('validation_error')
      expect(body_response[:error][:details]).to match({ 'name': ['is missing'] })
    end
  end

  context 'when name an optional param is provided but not in the proper format' do
    let(:grouping) { 'P' }

    it 'returns status code 422 with custom validation error' do
      get(url, params: params)

      expect(response).to have_http_status(422)
      expect(body_response[:error][:id]).to eq('validation_error')
      expect(body_response[:error][:details]).to match({ 'grouping': ['Invalid duration format'] })
    end
  end
end
