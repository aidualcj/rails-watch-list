Rails.application.routes.draw do
  resources :lists, only: [:index, :new, :create, :show] do
    resources :bookmarks, only: [:create]
  end
  resources :movies, only: [:index] # Si vous avez une page index pour les films
end
