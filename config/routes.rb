require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  resources :lots do
    get "/tag/:tag", on: :collection, to: "lots#tag", as: :tag
  end
  get 'my_lots', to: 'lots#my_lots'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', confirmations: 'users/confirmations' }
  root 'main#home'
end
