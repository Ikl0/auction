Rails.application.routes.draw do
  resources :lots
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', confirmations: 'users/confirmations' }
  root 'main#home'
end
