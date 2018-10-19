# frozen_string_literal: true

module Authenticator
  class User
    def legit?(email:, password:)
      user = ::User.find_by_email(email)
      return user if user&.authenticate(password)

      false
    end
  end
end
