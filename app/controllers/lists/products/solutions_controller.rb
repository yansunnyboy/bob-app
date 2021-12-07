  class Lists::Products::SolutionsController < ApplicationController

    def create
      # TODO: should check that current_user is a contributor to current list
      list = List.find(params[:list_id])
      product = Product.find(params[:product_id])
      solution = Solution.new(list: list, product: product)
      # flash[:notice] = @solution.errors.full_messages.to_sentence unless @solution.save
      if solution.save
        redirect_back fallback_location: products_path, notice: "#{product.name.inspect} added to #{list.name.inspect}"
      else
        redirect_back fallback_location: list_path(list), alert: "COULD NOT add #{product.name.inpsect} to #{list.name.inspect}"
      end
    end
  end
