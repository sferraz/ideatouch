Rails.application.routes.draw do

  resources :notes do
    collection do
      delete 'destroy_multiple'
      put 'update_multiple'
      put 'vote_multiple'
    end
  end


  get '/users/:id/edit' ,to: 'users#edit', as:'userEdit'
  post '/users/:id/edit' ,to: 'users#edit', as:'userEditp'
  patch "users/:id" => "users#update", as: "user_update"

  resources :votes

  resources :participants

  resources :notifications

  Rails.application.routes.draw do
    resources :users, controller: 'users', only: Clearance.configuration.user_actions
  end


  get 'whatis/index'


  resources :notes

  resources :boards

  resources :dynamics
  get '/dynamics/:id/info', to: 'dynamics#info', as: 'info'
  get '/dynamics/:id/addParticipant', to: 'dynamics#addParticipant', as: 'addParticipant'
  get '/dynamics/:id/addBoard', to: 'dynamics#addBoard', as: 'addBoard'
  get '/dynamics/:id/statistics', to: 'dynamics#statistics', as: 'statistics'
  get '/dynamics/:id/votingResults', to: 'dynamics#votingResults', as: 'votingResults'
  get '/boards/:id/addNote', to: 'boards#addNote', as: 'addNote'

  get '/boards/:id/moveNotes', to: 'boards#moveNotes', as: 'moveNotes'
  get '/boards/:id/votation', to: 'boards#votation', as: 'votation'

  get '/dynamics/:id/leave', to: 'dynamics#leave', as: 'leave'
  get '/dynamics/:id/activateVotation', to: 'dynamics#activateVotation', as: 'activateVotation'


  #get 'welcome/index'
  get 'box' => 'welcome#box'
  get 'design' => 'welcome#index'




  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'dynamics#index'

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
