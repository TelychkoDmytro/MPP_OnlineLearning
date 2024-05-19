Rails.application.routes.draw do
  # get 'groups/index'
  # get 'groups/new'
  # get 'groups/create'
  # get 'groups/show'
  resources :groups
  resources :subjects

  devise_for :teachers
  devise_for :students

  get 'login', to: 'login#new'
  get 'register', to: 'register#new'

  resources :profiles, only: [:show, :edit, :update]

  root to: "home#index"
end
