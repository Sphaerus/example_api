# frozen_string_literal: true

module Flow
  module Api
    module Internal
      class AuthorizeRequest
        def initialize(auth_token:)
          @auth_token = auth_token
        end

        def call
          if decoded_auth_token
            token_validator.validate!
            return user_repo.find!(decoded_auth_token[:user_id])
          end
          false
        end

        private

        attr_reader :auth_token

        def decoded_auth_token
          @decoded_auth_token ||= decoder.decode(token: token)
        end

        def decoder
          AuthToken::Decoder.new
        end

        def token_validator
          ::Validator::Token.new(decoded_auth_token: decoded_auth_token)
        end

        def user_repo
          Repository::User.new
        end

        def token
          return auth_token.split(' ').last if auth_token
          false
        end
      end
    end
  end
end
