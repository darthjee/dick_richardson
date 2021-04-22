# frozen_string_literal: true

Rails.application.routes.draw do
  resources :votings, only: [] do
    namespace :voting, path: '/' do
      resources :partials, only: :create do
        collection do
          get '/raw' => :index_raw
        end
      end
    end
  end
end
