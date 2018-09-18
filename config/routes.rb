Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#home'
  resources :contracts  do
    member do
      get 'download'
      get 'fbp_contract'
    end

  end

end
