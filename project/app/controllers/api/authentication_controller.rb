# frozen_string_literal: true

require './app/flows/api/authenticate_user.rb'

module Api
  class AuthenticationController < ApplicationController
    def authenticate
      token = Flow::Api::AuthenticateUser.new(email: params[:email], password: params[:password])
        .call

      if token
        render json: { auth_token: token }
      else
        render json: { error: t('errors.incorrect_credentials') }, status: :unauthorized
      end
    end
  end
end
