Rails.application.routes.draw do

  root 'welcome#index'
  get '/logout' => 'welcome#logout', :as => 'logout'

  resources :songs
  resources :users

end
