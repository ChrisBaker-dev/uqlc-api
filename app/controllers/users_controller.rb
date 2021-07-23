class UsersController < ApplicationController

    def login
        user = User.find_by_email(user_params[:email])
        #render plain: "#{user.email}"
        if user && user.authenticate(user_params[:password])
            payload = { email: user.email, admin: user.admin, user_id: user.id, exp: Time.now.to_i + 4 * 3600 }
            token = JWT.encode(payload, 'mysecretkey', 'HS512') # add key to ENV
            #render plain: 'Login worked'
            render json: { token: token, payload: payload }

        else 
            render json: { error: "Username or password incorrect" }, status: :unauthorized
        end
    end

    def register
        user = User.new(user_params)
        if user.save
            render json: { message: "User Created" }, status: :created
        else
            render json: { error: "Unable to register user" }, status: :unprocessable_entity
        end
    end

    private

    def user_params
        params.permit(:email, :password)
    end
end
