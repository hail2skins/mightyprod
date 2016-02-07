Mightysmalls::Application.routes.draw do

  devise_for :owners, controllers: { registrations: :registrations }
  
  resources :owners do
    resources :businesses
  end

  resources :businesses do
    member do
      get 'visits'
      get 'gift_certificates'
      get 'comps'
    end
    resources :customers do
      collection { post :search, to: 'customers#search' }
    end
    resources :packages
    resources :services
    resources :notifications
    resources :gift_certificates do
      patch :redeem, on: :member
      get :redeem, on: :member
      get :edit_redeem, on: :member
      put :edit_redeem, on: :member
      patch :edit_redeem, on: :member
    end
    resources :campaigns
  end

  resources :customers do
    resources :visits
    resources :deals
    resources :gift_certificates
    resources :comps
  end

  devise_scope :owner do
    get "/signup",        to: 'devise/registrations#new'
    get "/login",         to: 'devise/sessions#new'
    delete "/logout",     to: 'devise/sessions#destroy'
    get "/edit",          to: 'devise/registrations#edit'
  end

  root to: 'static_pages#home'

  get '/about',         to: 'static_pages#about'
  get '/help',          to: 'static_pages#help'
  get '/contact',       to: 'static_pages#contact'
  
  #In case I need this for direct e-mail.  
  #get :send_bulk_email,  to: 'businesses#send_bulk_email', as: :send_bulk_email
  #for the show page<%= link_to "Send mail to customers now", controller: "businesses", action: "send_bulk_email", id: @business.id %>
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
