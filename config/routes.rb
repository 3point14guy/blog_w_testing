Rails.application.routes.draw do
  root to: "articles#index"
  devise_for :users
  resources :articles do
    resources :comments
  end

  mount ActionCable.server => '/cable'
end
