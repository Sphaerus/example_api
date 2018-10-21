# frozen_string_literal: true

module Flow
  module Api
    module Internal
      class GetPrice
        def initialize(country_code:, target_group_id:, locations:)
          @country_code    = country_code
          @locations       = locations
          @target_group_id = target_group_id
        end

        def call
          params_validator.validate!
          country = country_repository.find_by_country_code!(country_code)
          calculator(country.panel_provider).calculate_price
        end

        private

        attr_reader :country_code, :locations, :target_group_id

        def calculator(provider)
          provider.set_calculator_class.new
        end

        def country_repository
          Repository::Country.new
        end

        def panel_provider_repository
          Repository::PanelProvider.new
        end

        def params_validator
          Validator::GetPriceParams.new(locations: locations)
        end
      end
    end
  end
end
