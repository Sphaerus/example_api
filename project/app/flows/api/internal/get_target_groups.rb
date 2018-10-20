# frozen_string_literal: true

module Flow
  module Api
    module Internal
      class GetTargetGroups
        def initialize(country_code:)
          @country_code = country_code
        end

        def call
          country = country_repository.find_by_country_code!(country_code)
          country.target_groups.with_provider(country.panel_provider_id)
        end

        private

        attr_reader :country_code

        def target_group_repository
          Repository::TargetGroup.new
        end

        def country_repository
          Repository::Country.new
        end
      end
    end
  end
end
