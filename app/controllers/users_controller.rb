class UsersController < ApplicationController

    def login
        user = User.find_by_email(user_params[:email])
        #render plain: "#{user.email}"
        if user && user.authenticate(user_params[:password])
            payload = { email: user.email, exp: Time.now.to_i + 4 * 3600 }
            token = JWT.encode(payload, 'mysecretkey', 'HS512') # add key to ENV
            #render plain: 'Login worked'
            render json: { token: token }

        else 
            render json: { error: "Username or password incorrect" }, status: :unauthorized
        end
    end

    def register
        user = 
    end

    private

    def user_params
        params.permit(:email, :password)
    end
end