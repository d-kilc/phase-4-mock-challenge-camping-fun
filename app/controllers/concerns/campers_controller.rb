class CampersController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :camper_not_found
rescue_from ActiveRecord::RecordInvalid, with: :invalid_record

    def index
        campers = Camper.all
        render json: campers, status: 200
    end

    def show
        camper_id = params[:id]
        camper = Camper.find camper_id
        render json: camper, status: 200, serializer: CamperDetailSerializer 
    end

    def create
        camper = Camper.create! camper_params
        render json: camper, status: 201 
    end

    private

    def camper_params
        params.permit :name, :age
    end

    def camper_not_found
        render json: { error: "Camper not found" }, status: 404
    end

    def invalid_record invalid
        render json: { errors: invalid.record.errors.to_a }, status: 422
    end
end
