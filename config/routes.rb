Rails.application.routes.draw do

  root 'welcome#index'

  resources :songs
  resources :users

end
