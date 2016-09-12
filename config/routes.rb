Rails.application.routes.draw do
  mount Commontator::Engine => '/commontator'
  devise_for :users, :controllers => { :omniauth_callbacks => 'omniauth_callbacks', registrations: 'registrations' }

  resources :reviews, except: :index do
    resources :amazon_ads, except: [:index, :show]
    member do
      post '/redirect_to_website' => 'reviews#redirect_to_website'
    end
  end

  resource :cards, only: [:create, :update]

  resources :products, except: [:index, :destroy]
  resources :users, only: :show do
    resources :reviewgroups, except: :show
  end
  root 'app#index'
  get '/pricing' => 'app#pricing', as: :pricing
  get '/register' => 'app#register'
  get '/search', to: 'app#search', as: :search
  post '/search_joy', to: 'app#search_joy'
  post '/set_country' => 'app#set_country'




  resources :places, except: :index
  resources :categories, only: :index

  authenticate :user, lambda { |u| u.reviewer? } do
    namespace :reviewer do
      root 'dashboard#index'
    end
  end

  authenticate :user, lambda { |u| u.admin? } do
    require 'sidekiq/web'
    Sidekiq::Web.set :session_secret, Rails.application.secrets[:secret_token]
    Sidekiq::Web.set :sessions, Rails.application.config.session_options
    mount Searchjoy::Engine, at: 'admin/searchjoy'
    mount Sidekiq::Web => '/sidekiq'
    namespace :admin do
      root 'dashboard#index'
      resources :categories
    end
  end


end
