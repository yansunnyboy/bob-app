class ContributorsController < ApplicationController

  def index
    @contributors = List.find(params[:list_id]).contributors
  end

  def new
    @contributor = Contributor.new
    @list = List.find(params[:list_id])
  end
end
