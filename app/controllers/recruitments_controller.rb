class RecruitmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @recruitment = Recruitment.new
  end

  def index
    @recruitment = Recruitment.all.page(params[:page]).per(5)
  end

  def show
    @recruitment = Recruitment.find(params[:id])
    @user = User.find_by(id: @recruitment.user_id)
  end

  def edit
    @recruitment = Recruitment.find(params[:id])
  end

  def create
    @recruitment = Recruitment.new(recruitment_params)
    @recruitment.user_id = current_user.id
    if @recruitment.save
      redirect_to recruitment_path(@recruitment.id)
      flash[:notice] = "投稿が完了しました"
    else
      flash.now[:alert] = "投稿内容を入力してください。"
      render :new
    end
  end

  def update
    @recruitment = Recruitment.find(params[:id])
    @recruitment.user_id = current_user.id
    if @recruitment.update(recruitment_params)
      flash[:notice] = "投稿の編集が完了しました"
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
      params.require(:recruitment).permit(:title, :store_name, :store_address, :store_image, :body, :genre)
    end

    def ensure_correct_user
      @recruitment = Recruitment.find(params[:id])
      unless @recruitment.user == current_user
        redirect_to recruitments_path
      end
    end
end