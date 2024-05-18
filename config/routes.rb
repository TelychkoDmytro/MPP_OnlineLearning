Rails.application.routes.draw do
  devise_for :teachers
  devise_for :students, controllers: {
    registrations: 'students/registrations'
  }

  get 'login', to: 'login#new'
  get 'register', to: 'register#new'

  resources :profiles, only: [:show, :edit, :update]

  root to: "home#index"
end
