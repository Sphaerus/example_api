# frozen_string_literal: true

module AuthToken
  class Decoder
    def decode(token:)
      JWT.decode(token, Rails.application.secrets.secret_key_base)[0].with_indifferent_access
    rescue StandardError
      false
    end
  end
end
