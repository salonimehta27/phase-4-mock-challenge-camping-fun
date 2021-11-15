class CampersController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_response_not_found
rescue_from ActiveRecord::RecordInvalid, with: :response_unprocessed_entity
    def index 
        # byebug
        campers=Camper.all 
        render json: campers
    end
    def show
        camper=Camper.find(params[:id])
        render json: camper, serializer: CamperWithActivitiesSerializer
    end

    def create 
        camper=Camper.create!(campers_param)
        render json: camper, status: :created
    end


    private

    def campers_param
        params.permit(:name,:age)
    end
    def render_response_not_found
        render json: {error: "Camper not found"}, status: :not_found
    end
    def response_unprocessed_entity(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
end
