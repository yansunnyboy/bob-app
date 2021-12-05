class ContributorsController < ApplicationController

  def index
    @contributors = List.find(params[:list_id]).contributors
  end

  def new
    @contributor = Contributor.new(user: User.new)
    @list = List.find(params[:list_id])
  end

  def create
    user = User.find_by(set_params[:user_attributes])
    list = List.find(params[:list_id])
    @contributor = Contributor.new(user: user, list: list)
    if @contributor.save
      redirect_to list_contributors_path(list)
    else
      render :new
    end
  end

  def remove
    list = List.find(params[:list_id])
    contributor = Contributor.find(params[:id])
    if contributor.delete
      redirect_to list_contributors_path(list)
    else
      #
    end
  end


  private
    def set_params
      params.require(:contributor).permit(user_attributes: :email)
    end
end
