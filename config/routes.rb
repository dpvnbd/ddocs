Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {sessions: 'sessions'}
  
  mount ActionCable.server => '/cable'
  root to: 'notes#index'

  resources :notes
end
