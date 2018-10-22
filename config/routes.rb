Rails.application.routes.draw do
  devise_for :users
  mount ActionCable.server => '/cable'
  root to: 'notes#index'
  get 'notes', to: 'notes#index'
end
