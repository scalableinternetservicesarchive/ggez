Rails.application.routes.draw do
  root 'pages#home'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#delete'

  get '/tutorial', to: 'pages#tutorial'

  resources :reviews, except: %i[index new show edit]

  resources :resumes, except: %i[index edit update]
  post '/resume/:id/swap_public', to: 'resumes#swap_public', as: 'swap_public'
  post '/resume/random', to: 'resumes#random', as: 'random_resume'

  resources :users, except: %i[index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
