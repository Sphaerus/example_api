# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Flow::Api::Internal::GetPrice do
  let(:flow) do
    described_class.new(
      country_code:    country_code,
      target_group_id: target_group_id,
      locations:       locations
    )
  end
  let(:locations) do
    [
      {
        id:         1,
        panel_size: 200
      }
    ]
  end
  let(:target_group_id) { rand(999) }
  let(:country_code)    { country.code }

  describe '#call' do
    subject { flow.call }

    context 'when country dont exist' do
      let(:country_code) { 'uk' }
      it 'raises error' do
        expect { subject }.to raise_error ResourceNotFound, 'Country not found'
      end
    end

    context 'when country and panel provider exist' do
      let!(:panel_provider) { create :panel_provider, code: panel_code }
      let!(:country)        { create :country, panel_provider: panel_provider }

      before do
        allow(HTTParty)
          .to receive(:get)
          .with('http://time.com')
          .and_return File.read('./spec/support/time.txt')
      end

      context 'when panel provider code times_a' do
        let(:panel_code) { 'times_a' }

        it 'returns proper price' do
          expect(subject).to eq 1163
        end
      end

      context 'when panel provider code times_html' do
        let(:panel_code) { 'times_html' }

        it 'returns proper price' do
          expect(subject).to eq 0.18
        end
      end

      context 'when panel provider code 10_arrays' do
        let(:panel_code) { '10_arrays' }
        before do
          allow(HTTParty)
            .to receive(:get)
            .with('http://openlibrary.org/search.json?q=the+lord+of+the+rings')
            .and_return File.read('./spec/support/open_library.json')
        end

        it 'returns proper price' do
          expect(subject).to eq 110
        end
      end
    end
  end
end
