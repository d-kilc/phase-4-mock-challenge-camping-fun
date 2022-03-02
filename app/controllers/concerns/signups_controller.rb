class SignupsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :invalid_record

    def index
        signups = Signup.all
        render json: signups, status: 200
    end

    def create
        signup = Signup.create! signup_params

        activity = Activity.find signup_params[:activity_id]
        render json: activity, status: 201
    end

    private

    def signup_params
        params.permit :time, :camper_id, :activity_id
    end

    def invalid_record invalid
        render json: { errors: invalid.record.errors.to_a }, status: 422
    end

end
