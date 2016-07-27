Rails.application.routes.draw do
  devise_for :users
  root 'app#index'

  namespace :places do
    resources :places
  end


end
