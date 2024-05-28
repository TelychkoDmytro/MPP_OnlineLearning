# frozen_string_literal: true

Rails.application.routes.draw do
<<<<<<< Updated upstream
  resources :schedules do
    member do
      get 'edit_attendances', to: 'student_attendances#edit', as: 'edit_attendances'
      patch 'update_attendances', to: 'student_attendances#update', as: 'update_attendances'
    end
  end
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
=======
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :schedules
>>>>>>> Stashed changes
  resources :groups
  resources :subjects do
    resources :tasks
    collection do
      get 'all_subjects'
    end
  end

  devise_for :teachers, controllers: {
    registrations: 'teachers/registrations'
  }

  devise_for :students, controllers: {
    registrations: 'students/registrations'
  }
  
  resources :students, only: [:index, :edit, :update] do
    member do
      get 'opt_out_subjects'
      post 'update_opt_out_subjects'
    end
  end

  get 'teachers/subjects_with_opt_outs', to: 'teachers#subjects_with_opt_outs', as: 'subjects_with_opt_outs'

  devise_scope :student do
    get 'students/edit_weather', to: 'students/registrations#edit_weather'
  end

  get 'login', to: 'login#new'

  get 'register', to: 'register#new'

  root to: 'home#index'
end
