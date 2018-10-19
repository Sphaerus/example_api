# frozen_string_literal: true

FactoryBot.define do
  factory :country do
    code              { 'code' }
    panel_provider_id { nil }
  end
end
