Rails.application.routes.draw do
  namespace :admin do
    resources :events
    resources :board_members
    resources :donors
    resources :email_records
    resources :parents
    resources :people
    resources :pets do
      delete :photo, on: :member, to: "pets#destroy_photo"
    end
    resources :transactions
    resources :users
    resources :volunteers
    resources :volunteer_applications

    root to: "board_members#index"
  end

  resources :volunteer_applications, only: [:new, :create] do
    get :thank_you, on: :collection
  end
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", :as => :rails_health_check

  resources :pets, only: [:index, :show]

  get "/" => "home#index", :as => :home
  get "/volunteer" => "pages#volunteer", :as => :volunteer
  get "/about" => "pages#about", :as => :about
  get "/adopt" => "pages#adopt", :as => :adopt

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
