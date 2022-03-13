class RecruitmentsController < ApplicationController
  def new
    @recruitment = Recruitment.new
  end

  def index
    @recruitment = Recruitment.all
    @user = @user_image
   
  end

  def show
    @recruitment = Recruitment.find(params[:id])
  end

  def edit
    @recruitment = Recruitment.find(params[:id])
  end

  def create
    @recruitment = Recruitment.new(recruitment_params)
    @recruitment.user_id = current_user.id
    if @recruitment.save
      redirect_to recruitment_path(@recruitment.id)
    else
      render :new
    end
  end

  def update
    @recruitment = Recruitment.find(params[:id])
    @recruitment.user_id = current_user.id
    if @recruitment.update(recruitment_params)
      redirect_to recruitments_path
    else
      render :edit
    end
  end

  def destroy
    @recruitment = Recruitment.find(params[:id])
    @recruitment.destroy
    redirect_to recruitments_path
  end

  private
    def recruitment_params
      params.require(:recruitment).permit(:title, :store_name, :store_address, :store_image, :body)
    end

end