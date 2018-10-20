# frozen_string_literal: true

FactoryBot.define do
  factory :location_group do
    name              { 'europe' }
    country_id        { nil }
    panel_provider_id { nil }
  end
end
