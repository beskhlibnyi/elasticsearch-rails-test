Rails.application.routes.draw do
  root 'posts#index'

  resources :posts do
    get :search
  end
end
