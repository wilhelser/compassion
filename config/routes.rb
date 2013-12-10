Compassion::Application.routes.draw do
  resources :pages


  ActiveAdmin.routes(self)
  resources :photos
  resources :estimates
  devise_for :adjusters, :path_prefix => 'my'
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  devise_for :contractors
  resources :contractor_reviews
  resources :donations
  resources :vendors

  root :to => "home#index"
  resources :addresses
  resources :galleries
  resources :references

  resources :contractors do
    resources :references
    member do
      get "dashboard"
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
      post "decline_assignment"
    end
  end

  resources :backers
  get "users/show"
  get "users/edit"
  resources :contributions
  resources :projects do
    member do
      post "set_project_contractor"
      post "share_on_facebook"
    end
    resources :contractor_selections
    resources :updates
    resources :contributions
    resources :vendors
    member do
      get "donate"
      get "dashboard"
      get "thank_you"
    end
  end

  resources :projects do
    resources :galleries
  end

  root :to => "home#index"
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
