# frozen_string_literal: true

module Repository
  class Country
    def find_by_country_code!(country_code)
      ::Country.find_by!(code: country_code)
    rescue ActiveRecord::RecordNotFound
      raise ResourceNotFound, 'Country not found'
    end
  end
end
