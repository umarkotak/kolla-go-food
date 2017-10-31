Rails.application.routes.draw do
  
  resources :categories
  resources :drinks

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
