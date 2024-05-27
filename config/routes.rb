# frozen_string_literal: true

Rails.application.routes.draw do
  # resources :student_subject_opt_outs
  resources :schedules
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

  root to: "home#index"
end
