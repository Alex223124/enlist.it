Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }, skip: [:sessions]
  as :user do
    delete 'users/sign_out' => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  root 'home#index'
  resources :services, except: :show
end
