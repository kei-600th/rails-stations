class MoviesController < ApplicationController

  before_action :authenticate_user!, except: [:show, :index]
  

  def index
    @movies = Movie.all
    if params[:is_showing].present?
      @movies = @movies.where(is_showing: params[:is_showing])
    end
    if params[:keyword].present?
      @movie = Movie.find(params[:id])
      @schedules = @movie.schedules
    end
  end

  def show
    @movie = Movie.includes(:schedules).find(params[:id])
    @schedules = @movie.schedules
    @dates = (Date.today..Date.today + 6.days).to_a
  end

  def reservation
    if params[:date].blank? || params[:schedule_id].blank?
      redirect_to movies_path
    else
      @sheets = Sheet.all
      @date = params[:date]
      @schedule = Schedule.find(params[:schedule_id])
      @movie = @schedule.movie

      @reserveds = @schedule.reservations.where(date: @date)
      @reserved_sheet_ids = @reserveds.pluck(:sheet_id)
    end
  end


  #showアクションを消してreservationアクションを追加する

end
