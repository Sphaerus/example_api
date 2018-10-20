# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root controller: :pages, action: :root

  namespace :api do
    post 'authenticate' => 'authentication#authenticate'
    namespace :internal do
      get 'locations'     => 'locations#locations'
      get 'target_groups' => 'target_groups#target_groups'
    end
    get 'locations' => 'locations#locations'
    get 'target_groups' => 'target_groups#target_groups'
  end
end
