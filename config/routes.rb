Rails.application.routes.draw do

  devise_for :users
  get '/' => 'products#index'
  get '/products' => 'products#index'
  get '/products/new' => 'products#new'
  post '/products/create' => 'products#create'
  get '/products/:id' => 'products#show' 
  get '/products/:id/edit' => 'products#edit'
  patch '/products/:id' => 'products#update'
  delete '/products/:id' => 'products#destroy'

  post '/search' => 'products#run_search'

  get '/' => 'suppliers#index'
  get '/suppliers' => 'suppliers#index'
  get '/suppliers/new' => 'suppliers#new'
  post '/suppliers/create' => 'suppliers#create'
  get '/suppliers/:id' => 'suppliers#show' 
  get '/suppliers/:id/edit' => 'suppliers#edit'
  patch '/suppliers/:id' => 'suppliers#update'
  delete '/suppliers/:id' => 'suppliers#destroy'

  get '/images/new' => 'images#new'
  post '/images/create' => 'images#create'

  post '/orders' => 'orders#create'
  get '/orders/:id' => 'orders#show' 

  post '/carted_products' => 'carted_products#create'
end