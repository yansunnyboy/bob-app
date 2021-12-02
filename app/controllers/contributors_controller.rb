class ContributorsController < ApplicationController

  def index
    @contributors = List.find(params[:list_id]).contributors
  end
end
