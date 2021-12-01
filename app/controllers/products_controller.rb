class ProductsController < ApplicationController
  before_action :find_product, only: %i[show edit update destroy toggle_category]

  def index
    product_scope = Product.all
    if !params[:category].nil?
      product_scope = product_scope.tagged_with(params[:category])
    end
    @pagy, @products = pagy(product_scope)
    @categories = product_scope.tag_counts_on(:categories)
  end


  def show
     @categories = ActsAsTaggableOn::Tag.all
     @bussinesses = ActsAsTaggableOn::Tag.all
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
    @bussinesses = ActsAsTaggableOn::Tag.all
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

   def toggle_bussiness
    if @product.bussiness_list.include?(params[:bussiness_name])
      @product.bussiness_list.remove(params[:bussiness_name])
    else
      @product.bussiness_list.add(params[:bussiness_name])
    end
    @product.save!
    redirect_to edit_product_path(@product)
  end


  private

  def find_product
    @product = Product.find(params[:id])
  end

  def set_params
    params.require(:product).permit(:name, :url, :bio, :info, :image_url)
  end
end
