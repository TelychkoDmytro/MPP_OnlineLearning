Rails.application.routes.draw do
  devise_for :teachers
  devise_for :students

  get 'login', to: 'login#new'
  get 'register', to: 'register#new'

  root to: "home#index"
end
