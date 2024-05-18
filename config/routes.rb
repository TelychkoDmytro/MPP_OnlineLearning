Rails.application.routes.draw do
  # get 'groups/index'
  # get 'groups/new'
  # get 'groups/create'
  # get 'groups/show'
  resources :groups

  devise_for :teachers
  devise_for :students, controllers: {
    registrations: 'students/registrations'
  }

  get 'login', to: 'login#new'
  get 'register', to: 'register#new'

  resources :profiles, only: [:show, :edit, :update]

  root to: "home#index"
end
