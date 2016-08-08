Rails.application.routes.draw do
  resources :products, except: [:index, :destroy]
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
