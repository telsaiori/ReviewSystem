Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :events do 
    resources :posts do 
      resources :comments
    end
  end

  root 'events#index'
end