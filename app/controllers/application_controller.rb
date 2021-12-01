class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(user)
   # stored_location_for(user) || welcome_path
    products_path
  end

end
