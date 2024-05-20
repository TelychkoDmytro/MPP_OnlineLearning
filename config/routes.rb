Rails.application.routes.draw do
  # get 'schedules/index'
  # get 'schedules/show'
  # get 'schedules/edit'
  # get 'schedules/new'
  # get 'students/index'
  # get 'students/show'
  # get 'students/edit'
  # get 'groups/index'
  # get 'groups/new'
  # get 'groups/create'
  # get 'groups/show'
  resources :schedules
  resources :t_students
  resources :groups
  resources :subjects

  devise_for :teachers, path: 'teachers'
  devise_for :students

  get 'login', to: 'login#new'
  get 'register', to: 'register#new'

  resources :profiles, only: [:show, :edit, :update]

  root to: "home#index"
end
