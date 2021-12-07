class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  layout "landing"
  def home
    @products = Product.all
    @categories = ActsAsTaggableOn::Tag.all
  end

  def index
  end
end
