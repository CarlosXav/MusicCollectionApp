Rails.application.routes.draw do
  resources :users, except: [:new]
  resources :albums, :artists
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#home"
  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'
  resources :albums, only: [:show]
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
