class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # rescue_from StandardError do |exception|
  #   render json: 'Something unusual happened. Please try again later', status: 500
  # end

  rescue_from InvalidInputError do |exception|
    render json: { error: exception.message }, status: 422
  end
end
