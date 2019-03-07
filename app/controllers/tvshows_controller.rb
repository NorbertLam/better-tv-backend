class TvshowsController < ApplicationController

  def index
    @tvshows = Tvshow.all
    render json: @tvshows
  end

  def show
    @user = User.find(session[:user_id])
    @tvshow = Tvshow.find(params[:id])
    render json: @tvshow
  end

  def create
    if Tvshow.find_by(tvshow_params)
      @tvshow = Tvshow.find_by(tvshow_params)
      @tvshow.update_attribute(:likes, @tvshow.users.count)
    else
      @tvshow = Tvshow.create(tvshow_params)
    end
    render json: @tvshow
  end

  def update
    @tvshow = Tvshow.find(params[:id])
    @tvshow.update(tvshow_params)
    render json: @tvshow
  end

  def destroy
    @tvshow = Tvshow.find(params[:id])
    @tvshow.destroy
  end

  private

  def tvshow_params
    params.permit(:name, :likes, :tvmaze_id)
  end

end