require 'rails_helper'

describe 'POST v1/metrics', type: :request do
  let(:url) { v1_metrics_url }

  let(:params) do
    {
      metric: {
        name: request_name,
        value: value,
        valid_at: valid_at,
      }.compact
    }
  end

  let(:headers) do
    {
      'CONTENT-TYPE': 'application/json',
    }
  end

  let(:request_name) { name }
  let(:name) { 'm0' }
  let(:value) { 3.141592653 }
  let(:valid_at) { Time.now.iso8601 }

  let(:mock_metrics_creator) { instance_double(Metrics::Creator, create!: created_metric) }

  let(:created_metric) { create(:metric, name: name, value: value, valid_at: valid_at) }

  let(:body_response) { response.parsed_body.with_indifferent_access }

  before do
    allow(Metrics::Creator).to receive(:new).and_return(mock_metrics_creator)
  end

  context 'when success' do
    it 'returns status code 201 and the created metric' do
      post(url, params: params.to_json, headers: headers)

      expect(response).to have_http_status(201)
      expect(body_response[:metric][:name]).to eq(name)
      expect(body_response[:metric][:value]).to eq(value)
      expect(Date.parse(body_response[:metric][:valid_at])).to eq(Date.parse(valid_at))
    end
  end

  context 'when a required param as name is not provided' do
    let(:request_name) { nil }

    it 'returns status code 422 with custom validation error' do
      post(url, params: params.to_json, headers: headers)

      expect(response).to have_http_status(422)
      expect(body_response[:error][:id]).to eq('validation_error')
      expect(body_response[:error][:details]).to match('metric': { 'name': ['is missing'] })
    end
  end

  context 'when a param is provided with the wrong format' do
    let(:valid_at) { '2023/02/12 17:00:00' }

    it 'returns status code 422 with custom validation error' do
      post(url, params: params.to_json, headers: headers)

      expect(response).to have_http_status(422)
      expect(body_response[:error][:id]).to eq('validation_error')
      expect(body_response[:error][:details]).to match('metric': { 'valid_at': ['Invalid valid_at format; expected iso8601'] })

    end
  end
end
