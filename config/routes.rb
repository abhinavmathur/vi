Rails.application.routes.draw do
  devise_for :users
  root 'app#index'
end
