Rails.application.routes.draw do
  
  resources :categories
  resources :drinks
  resources :orders
  # get '/drinks' => 'drinks#index'
  # get '/drinks/:id' => 'drinks#show'
  # get '/drinks/new' => 'drinks#new'
  # post '/drinks' => 'drinks#create'
  # get '/drinks/:id/edit' => 'drinks#edit'
  # patch '/drinks/:id' => 'drinks#update'
  # delete 'drinks/:id' => 'drinks#destroy'
  # delete 'drinks/:id/hapus' => 'drinks#hapus'

  resources :carts
  root 'store#index', as: 'store_index'

  get 'store/index'

  resources :buyers
  resources :foods
  resources :line_items



  get 'home/hello'
  get 'home/goodbye'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
