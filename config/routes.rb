Compassion::Application.routes.draw do
  get "assignments/destroy"
  resources :pages
  ActiveAdmin.routes(self)
  resources :photos
  resources :estimates
  devise_for :adjusters, :path_prefix => 'my'
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  devise_for :contractors, :controllers => { :registrations => 'contractors/registrations'}
  resources :contractor_reviews
  resources :donations
  resources :vendors
  root :to => "home#index"
  resources :addresses
  resources :references
  resources :galleries
  resources :contractors
  resources :assignments

  resources :contractors do
    resources :references
    resources :galleries
    member do
      get "dashboard"
      get "company_info"
      get "edit_profile"
    end
  end

  post "contractors/search"
  resources :updates
  resources :categories
  resources :donate
  get "dashboard/index"
  get "dashboard/projects"

  resources :adjusters do
    member do
      get "dashboard"
      get "assignments"
      get "estimates"
      get "edit_profile"
    end
  end

  resources :backers
  resources :contributions
  resources :projects do
    member do
      post "set_project_contractor"
      post "share_on_facebook"
      get "end_campaign"
      post "share_created"
      post "donate_remaining"
      get "extend_campaign"
      get "contractor"
      get "share"
      get "settings"
      get "action_galleries"
      get "donate"
      get "dashboard"
      get "thank_you"
    end
    resources :galleries
    resources :estimates, only: [:index]
    resources :contractor_selections
    resources :updates
    resources :contributions
    resources :vendors
  end

  get 'home/fb_callback'

  resources :users
  resources :users do
    member do
      get "dashboard"
    end
    resources :projects do
      member do
        get "dashboard"
      end
    end
  end
end
