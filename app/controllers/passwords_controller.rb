class PasswordsController < ApplicationController

    def forgot
        token = params[:token].to_s
        if params[:email].blank?
            return render json: { error: "Email not present"}, status: :unprocessable_entry
        end

        user = User.find_by_email(params[:email].downcase)

        if user.present? && user.confirmed_at?
            user.generate_password_token!
            # SEND EMAIL
            #UserMailer.with()
            render json: {status: 'ok'}, status: :ok
        else
            render json: {error: ['Email address not found. Please check and try again.']}, status: :not_found
        end
    end

    def reset
        token = params[:token].to_s

        if params[:email].blank?
            return render json: { error: "Token not present"}, status: :unprocessable_entry
        end

        user = User.find_by(reset_password_token: token)

        if user.present? && user.password_token_valid?
            if user.reset_password!(params[:password])
                render json: { message: "approved" }, status: :ok
            else
                render json: { error: "Could not reset password"}, status: :unprocessable_entity
            end
        else
            render json: { error: "Token or link expired, please create a new request" }, status: :not_found
        end
    end

    def update 
        if !params[:password].present?
            render json: { error: "Password not present" }, status: :unprocessable_entity
            return
        end
        if current_user.reset_password(params[:password])
            render json: { status: 'ok' }, status: :ok
        else
            render json: { errors: current_user.errors.full_messages }, status: :unprocessable_entity
        end
    end
end