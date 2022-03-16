class SearchesController < ApplicationController
  def search
    @range = params[:range]
    @recruitments = Recruitment.looks(params[:search], params[:word])
  end
end