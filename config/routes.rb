Rails.application.routes.draw do
  scope "/api/v1" do
    resources :posts

    scope '/players' do
      get '/showcase', to: 'players#showcase'
    end

    resources :players


    
    scope "/users" do
      post '/login', to: 'users#login'
      post '/register', to: 'users#register'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
