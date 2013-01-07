Arv2::Application.routes.draw do
  namespace :ventas do resources :presupuestos end

  namespace :ventas do resources :clientes end

  # mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  # mount RailsAdmin::Engine => '/intranet', :as => 'rails_admin'

  devise_for :users

  root :to => 'home#index'

  match '/history', :to => 'home#history'

  match '/servicios', :to => 'servicios#index'

  get "/intranet" => 'intranet#index', as: :intranet

  get "/cuenta" => 'cuenta#index', as: :cuenta
  post "/cuenta/show" => 'cuenta#show', as: :show_cuenta

  get "/garantia" => 'garantia#index', as: :garantia
  post "/garantia/show" => 'garantia#show', as: :show_garantia
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
  
end
