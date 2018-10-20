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

LOCATION_GROUPS = [
  'group_1',
  'group_2',
  'group_3'
]

TARGET_GROUPS = [
  'name_1',
  'name_2',
  'name_3',
  'name_4'
]

PANEL_PROVIDERS_CODES.each { |panel_provider_code| PanelProvider.create!(code: panel_provider_code) }

COUNTRIES.each do |country|
  Country.create!(
    code: country.fetch(:code),
    panel_provider: PanelProvider.find_by!(code: country.fetch(:panel_provider_code))
  )
end

LOCATION_GROUPS.each_with_index do |name, index|
  LocationGroup.create!(name: name, panel_provider: PanelProvider.all[index], country: Country.all[rand(2)])
end
LocationGroup.create!(name: 'name here yo', panel_provider: PanelProvider.first, country: Country.all[rand(2)])

LOCATIONS.each do |location|
  Location.create!(
    name: location.fetch(:name),
    external_id: SecureRandom.uuid,
    secret_code: SecureRandom.hex(64),
    location_group: LocationGroup.all[rand(3)]
  )
end

TARGET_GROUPS.each_with_index do |name, index|
  TargetGroup.create(name: name, panel_provider: PanelProvider.all[index])
end

TargetGroup.where(parent_id: nil).each do |target_group|
  target_group_node_1 = TargetGroup.create(
    name: "dummy_name#{rand(999)}",
    panel_provider: PanelProvider.all[0],
    parent: target_group
  )
  target_group_node_2 = TargetGroup.create(
    name: "dummy_name#{rand(999)}",
    panel_provider: PanelProvider.all[1],
    parent: target_group_node_1
  )
  target_group_node_3 = TargetGroup.create(
    name: "dummy_name#{rand(999)}",
    panel_provider: PanelProvider.all[2],
    parent: target_group_node_2
  )
end
