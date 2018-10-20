# frozen_string_literal: true

class ValidationError < StandardError; end
class ResourceNotFound < StandardError; end
Dir[Rails.root.join('app', '**', '*.rb')].each { |f| require f }
