# frozen_string_literal: true

module AuthToken
  class Encoder
    def encode(user_id:, expiration_date:)
      body = { user_id: user_id, expiration_date: expiration_date }
      JWT.encode(body, Rails.application.secrets.secret_key_base)
    end
  end
end
