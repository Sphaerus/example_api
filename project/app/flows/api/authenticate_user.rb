# frozen_string_literal: true

module Flow
  module Api
    class AuthenticateUser
      def initialize(email:, password:)
        @email    = email
        @password = password
      end

      def call
        return encoded_token if user_authenticated
        false
      end

      private

      attr_reader :email, :password

      def user_authenticated
        @user_authenticated ||= authenticator.legit?(email: email, password: password)
      end

      def tomorrow
        Date.today + 1.days
      end

      def encoded_token
        encoder.encode(user_id: user_authenticated.id, expiration_date: tomorrow)
      end

      def authenticator
        Authenticator::User.new
      end

      def encoder
        AuthToken::Encoder.new
      end
    end
  end
end
