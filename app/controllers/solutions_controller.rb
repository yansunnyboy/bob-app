class SolutionsController < ApplicationController
  before_action :set_list, only: %i[new create]

  def new
    @solution = Solution.new
  end

  def create
    @solution = Solution.new(solution_params)
    @solution.list = @list
    flash[:notice] = @solution.errors.full_messages.to_sentence unless @solution.save
    redirect_to list_path(@list)
  end

  def destroy
    @solution = Solution.find(params[:id])
    @solution.destroy
    redirect_to list_path(@solution.list)
  end

  private

  def solution_params
    params.require(:solution).permit(:product_id)
  end

  def set_list
    @list = List.find(params[:list_id])
  end
end
