class ProductsController < ApplicationController
  before_action :find_product, only: %i[show edit update destroy toggle_category]
  def index
    @pagy, @products = pagy(Product.all)
  end

  def show
     @categories = ActsAsTaggableOn::Tag.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(set_params)
    if @product.save
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  def edit
    @categories = ActsAsTaggableOn::Tag.all
  end

  def update
    @product.update(set_params)
    redirect_to product_path(@product)
  end

  def destroy
    @product.destroy
    redirect_to products_path
  end

  def toggle_category
    if @product.category_list.include?(params[:category_name])
      @product.category_list.remove(params[:category_name])
    else
      @product.category_list.add(params[:category_name])
    end
    @product.save!
    redirect_to edit_product_path(@product)
  end

  private

  def find_product
    @product = Product.find(params[:id])
  end

  def set_params
    params.require(:product).permit(:name, :url)
  end
end
