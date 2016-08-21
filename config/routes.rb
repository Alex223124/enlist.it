require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }, skip: [:sessions]
  as :user do
    delete 'users/sign_out' => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  root 'home#index'
  resources :services, except: [:show, :new, :edit]
end
