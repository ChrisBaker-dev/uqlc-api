Rails.application.routes.draw do
  scope "/api/v1" do
    resources :posts
    
    scope "/users" do
      post '/login', to: 'users#login'
      post '/register', to: 'users#register'
      post 'password/forgot', to: 'password#forgot'
      post 'password/reset', to: 'password#reset'
      put 'password/update', to: 'password#update'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
