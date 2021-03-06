Rails.application.routes.draw do

  root 'pages#home'
  get 'about' => 'pages#about'

  get 'signup' => 'users#new'
  get 'login'=> 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :articles
  resources :users, except: [:new]
  resources :categories, except: [:destroy]

end
