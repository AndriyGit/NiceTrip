Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'registrations' }

  root 'base_objects#index'

  resources :base_objects, only: [:edit, :index, :show]

  get 'base_objects/new/:type' => 'base_objects#new', as: :new_base_object

  resources :hotels
  resources :showplaces
  resources :caterings
  resources :relaxation_places

  get 'my_account' => 'users#show', as: :my_account
  get 'users/set_locale/:locale' => 'users#set_locale', as: :set_locale
  get 'users/edit_user/:type' => "users#edit_user", as: :edit_user
  patch 'users/upload_avatar' => 'users#upload_avatar', as: :upload_avatar
  get 'users/delete_avatar' => 'users#delete_avatar', as: :delete_avatar
  post 'users/save_user_name' => "users#save_user_name"
  post 'users/save_user_password' => "users#save_user_password"

  # resources :users

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
end
