Rails.application.routes.draw do


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  get 'applications/setverified/:id' => 'applications#setverified'
  get 'applications/setattended/:id' => 'applications#setattended'
  get 'users/settype/:id' => 'users#settype'
  get '/projects/:id/direction' => 'projects#direction'
  get '/projects/:id/notice' => 'projects#notice'
  get 'users/check_available' => 'users#check_available'
  post '/user/login' => 'user#login'
  get '/user/logout' => 'user#logout'
  root :to => 'user#index'


  resources :pickup_sites, :residents, :nurses
  resources :rooms do
    resources :residents
  end
  resources :zones do
    resources :rooms
  end

  resources :assignments, :records, :managements, :nursings, :applications 

  resources :projects do
    resources :applications, :assignments
  end

  resources :nursing_homes do
    resources :managements, :projects, :zones, :rooms, :residents, :nurses
  end

  resources :users do
    resources :applications, :messages
  end

  resources :messages

end
