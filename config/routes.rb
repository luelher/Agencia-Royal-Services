Arv2::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  mount RailsAdmin::Engine => '/intranet', :as => 'rails_admin'

  devise_for :users

  root :to => 'home#index'

  match '/history', :to => 'home#history'

  match '/servicios', :to => 'servicios#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
