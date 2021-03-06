class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show save_to_session nav_count]
  before_action :find_product,
                only: %i[show edit update destroy toggle_category toggle_business toggle_cost add_to_list create_solution_from_product
                         save_to_session]

  def index
    product_scope = Product.all.order(:id)
    product_scope = product_scope.tagged_with(params[:category]) unless params[:category].nil?
    @pagy, @products = pagy(product_scope, size: [1, 1, 1, 1])
    @categories = product_scope.tag_counts_on(:categories)
    @lists = List.all
    @solution = Solution.new
  end

  def show
    @product = Product.find(params[:id])
    @categories = ActsAsTaggableOn::Tag
                  .all
                  .reject { |tag| Product::BUSINESS_SIZES.include? tag.name }
                  .reject { |tag| Product::COST_CATEGORIES.include? tag.name }
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
    @categories = ActsAsTaggableOn::Tag
                  .all
                  .reject { |tag| Product::BUSINESS_SIZES.include? tag.name }
                  .reject { |tag| Product::COST_CATEGORIES.include? tag.name }
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

  def toggle_cost
    if @product.cost_list.include?(params[:cost_name])
      @product.cost_list.remove(params[:cost_name])
    else
      @product.cost_list.add(params[:cost_name])
    end
    @product.save!
    redirect_to edit_product_path(@product)
  end

  def toggle_business
    if @product.business_list.include?(params[:business_name])
      @product.business_list.remove(params[:business_name])
    else
      @product.business_list.add(params[:business_name])
    end
    @product.save!
    redirect_to edit_product_path(@product)
  end

  def add_to_list
    # change to user list
    @lists = List.all
    @solution = Solution.new
  end

  def create_solution_from_product
    @list = List.find(params[:solution][:list])
    @solution = Solution.create(list: @list, product: @product)
    redirect_to products_path
  end

  def toggle_vote
    list = List.find(params[:list_id])
    product = Product.find(params[:id])
    contributor = Contributor.find_by(list: list, user: current_user)
    solution = Solution.find_by(list: list, product: product)
    if contributor.voted_for?(solution)
      solution.unliked_by contributor
    else
      solution.liked_by contributor
    end

    redirect_back fallback_location: list_product_path(list: list, product: product)
  end

  def save_to_session
    session[:saved_products] ||= []
    if session[:saved_products].include?(@product.id)
      session[:saved_products] = session[:saved_products].reject { |p| p == @product.id }
    else
      session[:saved_products] << @product.id
    end
    respond_to do |format|
      @no_classes = true # HACK: to remove shared/_container wrapping for re-render
      format.html # Follow regular flow of Rails
      format.text { render partial: 'products/product', locals: { product: @product }, formats: [:html] }
    end
  end

  def nav_count
    render partial: 'shared/navbar'
  end

  private

  def find_product
    @product = Product.find(params[:id])
  end

  def set_params
    params.require(:product).permit(:name, :url, :bio, :info, :image_url)
  end
end
