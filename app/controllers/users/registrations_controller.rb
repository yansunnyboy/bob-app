# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    # valid_list_token if params[:list_invite_token]
    super do |resource|
      if resource.password.blank? && params[:passwordless_signup]
        temp_password = SecureRandom.hex(16)

        resource.password = temp_password
        resource.password_confirmation = temp_password
        resource.save
      end
    end
    add_saved_products if session[:saved_products]
    signup_to_list if params[:list_invite_token]
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  private

  def add_saved_products
    list = List.create!(name:"My saved list!")
    # contributor = Contributor.create!(user_id: resource, role: "owner")
    Contributor.create!(user: resource, role: "owner", list: list)
    saved_product_ids = session[:saved_products]
    saved_product_ids.each do |id|
      Solution.create!(product_id: id, list: list)
    end
    session[:saved_products] = nil
  end

  def signup_to_list
    result = JWT.decode(
      params[:list_invite_token],
      Rails.application.secret_key_base,
      true,
      algorithm: "HS256"
    )
    list = List.find(result[0]["list_id"])
    return unless resource.errors.empty?
    session["user_return_to"] = list_url(list)
    Contributor.create!(user: resource, role: "editor", list: list)
  end
end
