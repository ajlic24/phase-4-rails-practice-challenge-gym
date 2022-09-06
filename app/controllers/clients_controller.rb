class ClientsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_record

    def index
        render json: Client.all, status: :ok, include: [:membership]
    end

    def show
        client = find_client
        render json: client, status: :ok 
    end

    def create
        client = Client.create!(client_params)
        render json: client, status: :created 
    end

    def destroy
        client = find_client
        render json: client.destroy, status: :gone
    end

    def update
        client = find_client
        client.update!(client_params)
        render json: client, status: :ok
    end

    private

    def client_params
        params.permit(:name, :age)
    end

    def find_client
        Client.find(params[:id])
    end
    
    def render_not_found_response
        render json: {error: "Client not found"}, status: :not_found 
    end

    def render_invalid_record(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
end
