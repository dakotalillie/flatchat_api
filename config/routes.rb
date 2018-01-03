Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/login', to: 'sessions#create'
      post '/signup', to: 'users#create'
      get '/current_user', to: 'sessions#show'
      get '/user/:id/conversations', to: 'conversations#index'
      get '/conversation/:id/messages', to: 'conversations#show'
      post '/messages', to: 'messages#create'
      post '/conversations', to: 'conversations#create'
      post '/conversation/view', to: 'conversations#view'
      get '/search/users/:query', to: 'users#search'
      get '/search/users/exact/:query', to: 'users#exact_search'
      put '/conversation/:conversation_id/remove_user/:user_id', to: 'conversations#remove_user'
      mount ActionCable.server => '/cable'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
