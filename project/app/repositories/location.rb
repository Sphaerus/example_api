# frozen_string_literal: true

module Repository
  class Location
    def find_by_country(country)
      return [] unless country
      country.location_groups.with_provider(country.panel_provider_id).map(&:locations).flatten
    end
  end
end
