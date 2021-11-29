class ProductsController < ApplicationController
  before_action :find_product, only: %i[show edit update destroy]
  def index
    @products = Product.all
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(set_params)
    @product.save
    redirect_to product_path(@product)
  end

  def edit
  end

  def update
    @product.update(set_params)
    redirect_to product_path(@product)
  end

  def destroy
    @product.destroy
    redirect_to product_path
  end

  private

  def find_product
    @product = Product.find(params[:id])
  end

  def set_params
    params.require(:product).permit(:name, :url)
  end
end
