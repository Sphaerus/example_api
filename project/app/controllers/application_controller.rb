# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true

  rescue_from StandardError, with: :present_error

  def present_error(exception)
    render json: { error: exception.message }
  end
end
