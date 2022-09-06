class GymsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_record

    def index
        render json: Gym.all, status: :ok
    end

    def show
        gym = find_gym
        render json: gym, status: :ok 
    end

    def create
        gym = Gym.create!(gym_params)
        render json: gym, status: :created 
    end

    def destroy
        gym = find_gym
        gym.destroy
        render json: gym, status: :no_content
    end

    def update
        gym = find_gym
        gym.update!(gym_params)
        render json: gym, status: :ok
    end

    private

    def gym_params
        params.permit(:name, :address)
    end

    def find_gym
        Gym.find(params[:id])
    end
    
    def render_not_found_response
        render json: {error: "Gym not found"}, status: :not_found 
    end

    def render_invalid_record(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
end
