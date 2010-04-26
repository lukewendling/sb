ActionController::Routing::Routes.draw do |map|
  map.resources :forgot_passwords, :only => [:index, :new, :create], :controller => 'forgot_password', :as => 'forgot_password'
  map.resources :invitations, :only => [:new, :create]
  map.resource :authorization
  map.resources :events
  map.resources :challenges do |challenge|
    challenge.resources :challenge_comments, :name_prefix => nil, :as => 'comments' 
    challenge.resources :challenge_preferences, :name_prefix => nil, :as => 'preferences', :member => {:toggle_hidden => :put}
  end
  map.resources :sessions, :only => [:new, :create, :destroy]
  map.resources :friends, :member => {:contact_list => :get}
  
#  uncomment after removing beta invites
#  map.signup 'signup', :controller => 'friends', :action => 'new'
#  beta invites signup route
  map.signup 'signup/:invitation_token', :controller => 'friends', :action => 'new'
  map.logout 'logout', :controller => 'sessions', :action => 'destroy'
  map.login 'login', :controller => 'sessions', :action => 'new'

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)
  map.accept_challenge 'challenge_accepted/:id', :controller => 'challenges', :action => 'accept'
  map.pages 'pages/:action', :controller => 'pages'

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "sessions", :action => "new"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
