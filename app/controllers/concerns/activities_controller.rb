class ActivitiesController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :activity_not_found

    def index
        activities = Activity.all
        render json: activities, status: 200
    end

    def destroy
        activity_id = params[:id]
        activity = Activity.find activity_id
        activity.destroy
        render json: {}, status: 204
    end

    private

    def activity_not_found
        render json: {error: "Activity not found"}, status: 404
    end
end
