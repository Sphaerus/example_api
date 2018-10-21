# frozen_string_literal: true

module Validator
  class Base
    include ActiveModel::Validations

    def validate!
      return true if valid?
      fail ValidationError, errors.messages
    end
  end
end
