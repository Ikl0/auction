require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  resources :lots do
    get "/tag/:tag", on: :collection, to: "lots#tag", as: :tag
    resources :bids, only: [:create]
  end
  get 'won_lots', to: 'lots#won_lots'
  get 'my_lots', to: 'lots#my_lots'
  get '/best_lots', to: 'lots#best_lots', as: 'best_lots'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', confirmations: 'users/confirmations' }
  root 'lots#best_lots'
end
