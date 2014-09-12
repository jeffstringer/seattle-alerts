SeattleAlerts::Application.routes.draw do
  root 'static_pages#index'
  match '/about',           to: 'static_pages#about',   via: 'get'
  match '/stayinformed',    to: 'subscribers#new',      via: 'get'
  match '/signin',          to: 'sessions#new',         via: 'get'
  match '/signout',         to: 'sessions#destroy',     via: 'delete'
  match '/contact',         to: 'contacts#new',         via: 'get'
  resources :subscribers
  resources :sessions, only: [:new, :create, :destroy]
end
