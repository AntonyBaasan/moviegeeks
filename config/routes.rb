Rails.application.routes.draw do

  resources :encouragements

  devise_for :users
  get 'welcome/index'

  resources :achievements

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'
end
