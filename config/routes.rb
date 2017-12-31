Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/login', to: 'sessions#create'
      get '/current_user', to: 'sessions#show'
      get '/user/:id/conversations', to: 'conversations#index'
      get '/conversation/:id/messages', to: 'conversations#show'
      post '/messages', to: 'messages#create'
      post '/conversation/view', to: 'conversations#view'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
