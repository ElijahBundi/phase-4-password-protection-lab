class UsersController < ApplicationController
  # rescue_from ActiveRecord::RecordInvalid, with: record_invalid_response
    # rescue_from ActiveRecord::RecordNotFound, with: record_not_found_response

    def create
        user = User.create!(user_params)
        if user
            session[:user_id] ||= user.id
            render json: user, status: :created 
        else
            render json: {error: user.errors.full_messages}, status: :unprocessable_entity
        end  
    end

    def show
        user = User.find(session[:user_id])
        if user
            render json: user, status: :created
        else
            render json: {error: "Couldn't find User without an ID"}, status: :not_found
        end
    end

    private

    def user_params
        params.permit(:username, :password, :password_confirmation)
    end

end
