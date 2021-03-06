Rails.application.routes.draw do
    #get 'owner_compare/:owner', to: 'graph#owner_compare'

get 'compare', to: 'compare#index'

 get 'compare/:repos', to: 'compare#compare'
  
  
   get 'org', to: 'org#index'
  
  match 'org/:org_name' => 'org#show', via: :post


get 'repo', to: 'repo#index'

match 'repo/:repo_name' => 'repo#show', via: :post


  #resources :user
   resources :compare
  resources :repo
  resources :org

  #get ':controller/:action/:owner/:repo_name'
   get 'git_stuff/text/:owner/:repo_name', to: 'git_stuff#text'
  get 'welcome/home'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#home'

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
