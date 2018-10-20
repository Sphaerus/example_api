# frozen_string_literal: true

module Flow
  module Api
    module Internal
      class GetLocations
        def initialize(country_code:)
          @country_code = country_code
        end

        def call
          country = country_repository.find_by_country_code!(country_code)
          locations_repository.find_by_country(country)
        end

        private

        attr_reader :country_code

        def locations_repository
          Repository::Location.new
        end

        def country_repository
          Repository::Country.new
        end
      end
    end
  end
end
