Arv2::Application.routes.draw do
  namespace :ventas do 
    resources :seguimientos
  end

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

  get "/intranet" => 'intranet#index', :as => :intranet

  get "/cuenta" => 'cuenta#index', :as => :cuenta
  post "/cuenta/show" => 'cuenta#show', :as => :show_cuenta

  get "/productos" => 'productos#index', :as => :productos
  post "/productos/show" => 'productos#show', :as => :show_productos

  get "/garantia" => 'garantia#index', :as => :garantia
  post "/garantia/show" => 'garantia#show', :as => :show_garantia

  match '/historia', :to => 'historia#index'
  match '/contacto', :to => 'contacto#index'  

  match '/servicios', :to => 'servicios#index'

  get "/cobranzas" => 'cobranzas#index', :as => :cobranzas
  get "/cobranzas/historico/:fac_num" => 'cobranzas#historico', :as => :historico_cobranzas_by_factura
  get "/cobranzas/historico" => 'cobranzas#historico', :as => :historico_cobranzas
  post "/cobranzas/show" => 'cobranzas#show', :as => :show_cobranzas
  put "/cobranzas/update" => 'cobranzas#update', :as => :update_cobranzas


  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
  
end
