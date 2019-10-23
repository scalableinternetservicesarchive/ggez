Rails.application.routes.draw do
  root 'pages#home'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#delete'

  get '/tutorial', to: 'pages#tutorial'

  resources :reviews, except: %i[index new show edit]
  resources :resumes, except: %i[edit update]
  resources :users, except: %i[index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
