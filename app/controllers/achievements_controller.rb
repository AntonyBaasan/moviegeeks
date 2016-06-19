class AchievementsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  # in real work user pundit
  before_action :owners_only, only: [:edit, :update, :destroy]

  def index
    @achievements = Achievement.public_access
  end

  def new
    @achievement = Achievement.new
  end

  def edit
  end

  def update
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
    @achievement.destroy

    redirect_to achievement_path
  end

  def create
    @achievement = Achievement.new(achievement_params)
    @achievement.user = current_user
    if @achievement.save
      # TODO: move to model
      UserMailer.achievement_created(current_user.email, @achievement.id).deliver_now
      redirect_to achievement_path(@achievement), notice: 'Achievement has been created'
    else
      render :new
    end
  end

  private

  def achievement_params
    params.require(:achievement).permit(:title, :description, :privacy, :featured, :cover_image)
  end

  def owners_only
    @achievement = Achievement.find(params[:id])
    # current_user value is provided by Devise
    if (current_user != @achievement.user)
      redirect_to achievements_path
    end
  end

end
