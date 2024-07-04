Rails.application.routes.draw do
  root "lists#index"

  resources :lists do
    resources :bookmarks, only: [:new, :create, :destroy]
  end
end
