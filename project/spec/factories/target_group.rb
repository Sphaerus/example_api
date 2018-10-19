# frozen_string_literal: true

FactoryBot.define do
  factory :target_group do
    name              { 'name' }
    external_id       { nil }
    parent_id         { nil }
    secret_code       { 'secret_code' }
    panel_provider_id { nil }
  end
end
