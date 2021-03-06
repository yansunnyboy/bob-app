class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  include Pagy::Backend

  # rescue_from ActiveRecord::RecordInvalid, with: :show_errors
  # rescue_from ActiveRecord::RecordNotFound, with: :show_errors

  # def after_sign_in_path_for(user)
  # stored_location_for(user) || welcome_path
  # products_path
  # end

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    # devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: %i[full_name business_name])
  end

  private

  def show_errors(exception)
    # TODO: would new record ever come here?
    # exception.record.new_record? ? ...
    redirect_to root_path, alert: exception.message
  end
end
