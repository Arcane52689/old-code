Rails.application.routes.draw do

  resources :users, only: [:new, :show, :create, :index] do
    collection do
      get 'activate'
    end
    member do
      put 'make_admin'
    end
  end

  resource :session, only: [:new, :create, :destroy]

  resources :bands
  resources :albums, exempt: [:index]
  resources :tracks , exempt: [:index] do
    resource :note, only:[:create]
  end

  resources :notes, only: [:destroy]

end
