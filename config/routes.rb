Arv2::Application.routes.draw do
  namespace :ventas do resources :seguimientos end

  namespace :ventas do 
    resources :presupuestos do
      collection do
        get 'clientes'
        get 'productos'
      end
    end
  end

  namespace :ventas do resources :clientes end

  # 
  # 

  devise_for :users

  root :to => 'home#index'

  match '/historia', :to => 'historia#index'
  match '/contacto', :to => 'contacto#index'  

  match '/servicios', :to => 'servicios#index'
  match '/productos', :to => 'productos#index'  

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
