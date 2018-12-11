class RegistrationsController < DeviseTokenAuth::RegistrationsController
  def render_update_success
    render "users/success"
  end
end