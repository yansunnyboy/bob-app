class ContributorsController < ApplicationController
  def index
    @contributors = List.find(params[:list_id]).contributors
  end

  def new
    @contributor = Contributor.new(user: User.new())
    @list = List.find(params[:list_id])
    redirect_to list_path(@list)
  end

  def create
    user = User.find_by(email: set_params[:user])
    @list = List.find(params[:list_id])
    @contributor = Contributor.new(user: user, list: @list)
    if @contributor.save
      redirect_to list_contributors_path(@list)
    else
      flash.now[:notice] = "maybe could not find user: #{set_params[:user_attributes]}"
      render :new
    end
  end

  def remove
    list = List.find(params[:list_id])
    contributor = Contributor.find(params[:id])
    redirect_to list_contributors_path(list) if contributor.delete
  end

  private

  def set_params
    params.require(:contributor).permit(:user)
  end
end
