Icosplay::Application.routes.draw do

  match '/slide' => 'albums#slide'

  resources :cities

  resources :messages

  resources :avatars

  resources :rels

  resources :fans

  resources :comments

  resources :members

  resources :albums do
    member do
      get 'me'
    end

    resources :photos  do
      collection do
        post 'upload'
      end
      member do
        get 'next'
      end
    end
  end

  resources :communities do
    collection do
        get 'choice'
    end
  end

  resources :users do
    collection do
      get 'hot'
      get 'search_tag'
     
    end

    member do
      get 'favorite'
      get 'unfavorite'
      get 'home'
      get 'masters'
      get 'followers'
    end

    resources :photos do
      collection do
        get 'favorited'
      end
    end
  end

  resources :tags do
    resources :photos do
      collection do
        get 'by_tag'
      end
    end

    resources :users do
      collection do
        get 'by_tag'
      end
    end
  end

  root :to => "welcome#index"

  resources :photos do
    member do
      post 'inc'
      get 'favorite'
    end

    collection do
      get 'top'
      get 'search_tag'
      post 'upload'
      post 'search'
      get 'recommend'
      get 'latest'
    end
  end

  resource :session

  match 'login' => 'sessions#new'
  match 'logout' => 'sessions#destroy'

  match 'profile' => 'users#show'
  match 'register' => 'users#new'
  match 'add_tag_for_register'=> 'users#add_tag_for_register'

  match 'me_community' => 'communities#me'
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
