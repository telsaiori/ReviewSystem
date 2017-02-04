Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :events do 
    resources :posts do 
      resources :comments
    end
  end

  namespace :admin do
    resources :posts do 
      collection do 
        get :all_posts
        delete :del_posts_page
      end
    end

    resources :comments do 
      delete :del_comments, on: :collection
    end

    resources :events do 
      collection do 
        delete :del_events
      end
      resources :posts do 
        collection do 
          delete :del_posts
        end
        resources :comments
      end
    end
  end

  root 'events#index'
end
