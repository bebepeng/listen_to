Rails.application.routes.draw do

  root 'welcome#index'
  get '/logout' => 'welcome#logout'

  resources :songs
  resources :users

end
