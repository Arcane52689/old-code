  Rails.application.routes.draw do

  resources :cats

  resources :cat_rental_requests, only:[:create,:new, :show, :destroy] do
    member do
      patch "approve"
      patch "deny"
    end
  end

  resources :users, only: [:new, :create] do
    resources :sessions, only: [:index]
  end

  resource :session, only: [:create, :new, :destroy]

  resources :sessions, only: [] do
    member do
      delete "destroy_specific"
    end
  end
end
