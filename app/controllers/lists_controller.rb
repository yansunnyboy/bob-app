class ListsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[invite]
  before_action :find_list, only: %i[show edit destroy update invite]

  def index
    list_scope = List.joins(:contributors).where(contributors:{user:current_user})
    @pagy, @lists = pagy(list_scope)
  end

  def new
    @list = params.has_key?(:list) ? List.new(list_params) : List.new()
  end

  def show
    session["user_return_to"] = nil
    @solutions = Solution.where(list_id: params[:id])
    @contributor = Contributor.find_by!(list: @list, user: current_user)
    @products = []
    @solutions.each do |solution|
      @products << Product.find(solution.product_id)
    end
  end

  def create
    @list = List.create(list_params)
    params[:product_ids] && params[:product_ids].each do |product_id|
      Solution.create!(product_id: product_id, list: @list)
    end
    session[:saved_products] && session[:saved_products] do |product_id|
      Solution.create!(product_id: product_id, list: @list)
    end
    session[:saved_products] = []
    @list.contributors.create(user: current_user, role: "owner")
    redirect_to list_path(@list)
  end

  def edit
  end

  def update
    @list.update(list_params)
    redirect_to list_path(@list)
  end

  def destroy
    @list.destroy
    redirect_to lists_path
  end

  def invite
  end

  private

  def find_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :description)
  end
end
