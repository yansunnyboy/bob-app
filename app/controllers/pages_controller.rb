class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  layout "landing"
  def home
    @products = Product.all
    @categories = ActsAsTaggableOn::Tag.all
    if user_signed_in? && session["user_return_to"]
      redirect_to session["user_return_to"]
    else
      render
    end
  end

  def index
  end
end
