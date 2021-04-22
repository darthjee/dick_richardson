Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
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
