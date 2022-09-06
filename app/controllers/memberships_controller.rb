class MembershipsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_record

    def index
        render json: Membership.all, status: :ok
    end

    def show
        membership = find_membership
        render json: membership, status: :ok 
    end

    def create
        membership = Membership.create!(membership_params)
        render json: membership, status: :created 
    end

    def destroy
        membership = find_membership
        membership.destroy
        render json: membership, status: :no_content
    end

    def update
        membership = find_membership
        membership.update!(membership_params)
        render json: membership, status: :ok
    end

    private

    def membership_params
        params.permit(:charge, :client_id, :gym_id)
    end

    def find_membership
        Membership.find(params[:id])
    end
    
    def render_not_found_response
        render json: {error: "Membership not found"}, status: :not_found 
    end

    def render_invalid_record(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
end
