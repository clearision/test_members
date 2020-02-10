Rails.application.routes.draw do
  resources :members do
    member do
      post :add_friends
      get :search
    end
  end
end
