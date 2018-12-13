class BaseController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken

  before_action :authenticate_user!

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  protected

  def handle_not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end
end
