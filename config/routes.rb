Rails.application.routes.draw do
  resources :schedules
  resources :groups
  resources :subjects

  devise_for :teachers, controllers: {
    registrations: 'teachers/registrations'
  }
  devise_for :students, controllers: {
    registrations: 'students/registrations'
  }
  
  resources :students, only: [:index, :edit, :update]
  
  devise_scope :student do
    get 'students/edit_weather', to: 'students/registrations#edit_weather'
  end
  
  get 'login', to: 'login#new'
  get 'register', to: 'register#new'

  root to: "home#index"
end
