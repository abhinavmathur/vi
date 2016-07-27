Rails.application.routes.draw do
  devise_for :users
  root 'app#index'


    resources :places, except: :index


end
