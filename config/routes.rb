SeattleAlerts::Application.routes.draw do
  root 'main#index'
  match '/about',           to: 'main#about',   via: 'get'
  match '/stayinformed',    to: 'subscribers#new',      via: 'get'
  match '/signin',          to: 'sessions#new',         via: 'get'
  match '/signout',         to: 'sessions#destroy',     via: 'delete'
  resources :subscribers
  resources :sessions, only: [:new, :create, :destroy]
end
