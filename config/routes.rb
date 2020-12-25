Rails.application.routes.draw do
  devise_for :users

  resources :students, except: :show

  root 'students#index'
end
