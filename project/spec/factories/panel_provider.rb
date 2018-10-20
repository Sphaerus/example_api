# frozen_string_literal: true

FactoryBot.define do
  factory :panel_provider do
    code { "code#{rand(9999)}" }
  end
end
