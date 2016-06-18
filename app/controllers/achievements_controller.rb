class AchievementsController < ApplicationController
  def index
    @achievements = Achievement.public_access
  end

  def new
    @achievement = Achievement.new
  end

  def edit
    @achievement = Achievement.find(params[:id])
  end

  def update
    @achievement = Achievement.find(params[:id])

    if (@achievement.update_attributes(achievement_params))
      redirect_to achievement_path(@achievement)
    else
      render :edit
    end

  end

  def show
    @achievement = Achievement.find(params[:id])
  end

  def destroy
    Achievement.destroy(params[:id])

    redirect_to achievement_path
  end

  def create
    @achievement = Achievement.new(achievement_params)
    if @achievement.save
      redirect_to achievement_path(@achievement), notice: 'Achievement has been created'
    else
      render :new
    end
  end

  private

  def achievement_params
    params.require(:achievement).permit(:title, :description, :privacy, :featured, :cover_imaage)
  end
end
