Rails.application.routes.draw do
  devise_for :users


  resources :patients do
    collection do
      get 'doctor_index'
      get 'stats'  # This should be a collection route, not member
    end
  end
  resources :appointments
  


  root 'patients#index'
end
