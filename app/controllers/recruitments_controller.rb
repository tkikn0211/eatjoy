class RecruitmentsController < ApplicationController
  def new
    @recruitment = Recruitment.new
  end

  def index
    @recruitment = Recruitment.all
  end

  def show
    @recruitment = Recruitment.find(params[:id])
  end

  def edit
    @recruitment = Recruitment.find(params[:id])
  end

  def create
    @recruitment = Recruitment.new(recruitment_params)
    if @recruitment.save
      redirect_to recruitments_path
    else
      render :new
    end
  end

  def update
    @recruitment = Recruitment.find(params[:id])
    if @recruitment.update(recruitment_params)
      redirect_to recruitments_path
    else
      render :edit
    end
  end


  private
    def recruitment_params
      params.require(:recruitment).permit(:title, :store_name, :store_address, :store_image, :body)
    end


end
