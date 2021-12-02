class ListsController < ApplicationController
  before_action :find_list, only: %i[show edit destroy update]

  def index
    @lists = List.all
  end

  def new
    @list = List.new
  end

  def show
    @solution = Solution.new
  end

  def create
    @list = List.new(list_params)
    @list.contributors.build(user: User.first, role: "owner")
    @list.save!
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

  private

  def find_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name)
  end
end
