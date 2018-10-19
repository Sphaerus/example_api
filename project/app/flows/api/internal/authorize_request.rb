# frozen_string_literal: true

module Flow
  module Api
    module Internal
      class AuthorizeRequest
        def initialize(headers:)
          @headers = headers
        end

        def call
          return User.find(decoded_auth_token[:user_id]) if decoded_auth_token
          false
        end

        private

        attr_reader :headers

        def decoded_auth_token
          @decoded_auth_token ||= decoder.decode(token: token)
        end

        def decoder
          AuthToken::Decoder.new
        end

        def token
          return headers['auth_token'].split(' ').last if headers['auth_token'].present?
          false
        end
      end
    end
  end
end
