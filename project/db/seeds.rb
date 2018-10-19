# frozen_string_literal: true

PANEL_PROVIDERS_CODES = %w[times_a 10_arrays times_html].freeze

COUNTRIES = [
  { code: 'PL', panel_provider_code: 'times_a' },
  { code: 'US', panel_provider_code: '10_arrays' },
  { code: 'UK', panel_provider_code: 'times_html' }
].freeze

LOCATIONS = [
  { name: 'New York' },
  { name: 'Los Angeles' },
  { name: 'Chicago' },
  { name: 'Houston' },
  { name: 'Philadelphia' },
  { name: 'Phoenix' },
  { name: 'San Antonio' },
  { name: 'San Diego' },
  { name: 'Dallas' },
  { name: 'San Jose' },
  { name: 'Austin' },
  { name: 'Jacksonville' },
  { name: 'San Francisco' },
  { name: 'Indianapolis' },
  { name: 'Columbus' },
  { name: 'Fort Worth' },
  { name: 'Charlotte' },
  { name: 'Detroit' },
  { name: 'El Paso' },
  { name: 'Seattle' }
].freeze

PANEL_PROVIDERS_CODES.each { |panel_provider_code| PanelProvider.create!(code: panel_provider_code) }

COUNTRIES.each do |country|
  Country.create!(
    code: country.fetch(:code),
    panel_provider: PanelProvider.find_by!(code: country.fetch(:panel_provider_code))
  )
end

LOCATIONS.each do |location|
  Location.create!(
    name: location.fetch(:name),
    external_id: SecureRandom.uuid,
    secret_code: SecureRandom.hex(64)
  )
end
