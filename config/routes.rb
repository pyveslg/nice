Rails.application.routes.draw do
  get 'quote/show'
  get 'quote/create'
  get 'quote/update'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#home'
  resources :contracts  do
    member do
      get 'download'
      get 'fbp_contract'
    end

  end

  resources :quotes, only: [:new, :create, :show, :edit, :update]

  get 'reglement_interieur', to: 'documents#reglement_interieur', as: :regint

end
