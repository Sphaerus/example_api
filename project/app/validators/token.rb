# frozen_string_literal: true

module Validator
  class Token < Base
    validate :expiration_date_present
    validate :user_id_present
    validate :date_correctness

    def initialize(decoded_auth_token:)
      @decoded_auth_token = decoded_auth_token
    end

    private

    attr_reader :decoded_auth_token, :expiration_date

    def expiration_date_present
      return true if (@expiration_date = decoded_auth_token[:expiration_date])
      errors.add(:token, 'invalid')
    end

    def user_id_present
      return true if decoded_auth_token[:user_id]
      errors.add(:token, 'invalid')
    end

    def date_correctness
      return true if expiration_date && Date.parse(expiration_date) >= Date.today
      errors.add(:token, 'is expired')
    end
  end
end
