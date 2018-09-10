Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#home'
  get "frenchbooster", to: "pages#frenchbooster"
  get "cpi", to: "pages#cpi"
  resources :contracts, only: [:index, :new, :create, :show, :update]  do
    member do
      get 'download'
      get 'fbp_contract'
    end

  end

end
