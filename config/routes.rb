Rails.application.routes.draw do
  resources :reviews, except: :index
  resources :products, except: [:index, :destroy] do
    member do

    end

    collection do
      get 'new_review' => 'products#new_review'
      post '/create_review' => 'products#create_review'
    end


  end
  devise_for :users
  root 'app#index'

  resources :places, except: :index
  resources :categories, only: :index

  authenticate :user, lambda { |u| u.admin? } do
    namespace :admin do
      root 'dashboard#index'
      resources :categories
    end
  end


end
