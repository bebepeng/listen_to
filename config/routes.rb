Rails.application.routes.draw do

  root 'welcome#index'
  get '/logout' => 'sessions#destroy', :as => 'logout'
  get '/login' => 'sessions#new', :as => 'login'
  post '/login' => 'sessions#create'


  resources :users
  resources :songs
end
