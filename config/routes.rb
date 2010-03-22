Blog::Application.routes.draw do |map|
  resources :posts
  resources :users
  resources :comments

  match '/posts/:post_id/comments' => 'comments#list', :as => :post_comments

  scope '/session' do
    post '' => "sessions#create"
    get '/complete' => "sessions#complete", :as => "complete_session"
  end
  match '/login' => 'sessions#new', :as => :login
  match '/logout' => 'sessions#destroy', :as => :logout
  match '/archives' => 'home#archives', :as => :archives

  match "blog/page/:page" => redirect("/page/%{page}")
  match "blog/feed" => redirect("/feed")
  match "blog/" => redirect("/")
  match "blog/:y/:m/:d/:slug" => redirect("/post/%{slug}"), :y => /\d\d\d\d/, :m => /\d\d/, :d => /\d\d/
  match "blog/:y/:m/:d" => redirect("/archives"), :y => /\d\d\d\d/, :m => /\d\d/, :d => /\d\d/
  match "blog/:y/:m" => redirect("/archives"), :y => /\d\d\d\d/, :m => /\d\d/
  match "blog/:y" => redirect("/archives"), :y => /\d\d\d\d/
  match '/posts/:post_id/preview' => 'home#preview', :as => "preview_post"

  root :to => "home#index"
  get 'feed' => 'home#feed', :as => "feed"
  match 'page/:page' => 'home#index', :page => /\d+/, :as => "page"
  match 'categories/:category(/page/:page)' => 'home#index', :page => /\d+/, :as => "category"
  get '/:post_type/:slug/feed' => 'home#comment_feed', :as => "comment_feed"
  match '/:post_type/:slug' => 'home#content', :as => "content"

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
  #       get :short
  #       post :toggle
  #     end
  #
  #     collection do
  #       get :sold
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
  #       get :recent, :on => :collection
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

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
