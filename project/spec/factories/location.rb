# frozen_string_literal: true

FactoryBot.define do
  factory :location do
    name              { 'UK' }
    external_id       { 123 }
    secret_code       { 'secret' }
    location_group_id { nil }
  end
end
