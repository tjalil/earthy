Earthy::Application.routes.draw do


 #  EDITED BY ADRIANA: these are templates for how routes can be set up
  #  Assumptions: the id is the question id, the round/points are hidden params
 #  get 'game/:id/ask' => "games#ask"
 #  post 'game/:id/ask' => "game#validate"
 #  get 'game/:id/answer' => "game#display_answer"

  # EDITED BY JOSH: I set up a quick test route to properly integrate the view I made. Feel free to edit/delete this.

  get 'questions' => 'questions#index'
  
  post 'questions/ask' => 'questions#ask'
  

  post 'questions' => 'questions#validate'

  get 'questions/summary' => 'questions#summary', as: :summary

  post 'questions/newround' => 'questions#next_round', as: :newround

  root to: "questions#index"



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
