class Admin::SchedulesController < ApplicationController

  before_action :set_movie, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]

  def index
    @schedules = Schedule.includes(:movie).all
  end

  def new
    @schedule = @movie_cinema.schedules.build
  end

  def show
    @schedule = Schedule.find(params[:id])
  end

  def create
    @schedule = @movie_cinema.schedules.build(schedule_params)

    if @schedule.save
      redirect_to admin_movie_movie_cinema_path(@movie_cinema.movie, @movie_cinema)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @schedule.update(schedule_params)
      redirect_to admin_movie_movie_cinema_path(@movie_cinema.movie, @movie_cinema), notice: 'Schedule was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @schedule.destroy
    redirect_to admin_movie_movie_cinema_path(@movie_cinema.movie, @movie_cinema), notice: 'Schedule was successfully destroyed.'
  end



  private

  def set_movie
    @movie_cinema = MovieCinema.find(params[:movie_cinema_id])
  end

  def set_schedule
    @schedule = @movie_cinema.schedules.find(params[:id])
  end

  def schedule_params
    params.require(:schedule).permit(:start_time, :end_time)
  end


end
