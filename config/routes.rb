Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  
  mount ActionCable.server => '/cable'
  root to: 'notes#index'
  get 'notes', to: 'notes#index'
end
