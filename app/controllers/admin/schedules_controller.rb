class Admin::SchedulesController < ApplicationController

  before_action :set_movie, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]

  def index
    @schedules = Schedule.includes(:movie).all
  end

  def new
    @schedule = @movie.schedules.build
  end

  def show
    @schedule = Schedule.find(params[:id])
  end

  def create
    @schedule = @movie.schedules.build(schedule_params)

    if @schedule.save
      redirect_to movie_path(@movie)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @schedule.update(schedule_params)
      redirect_to admin_movie_path(@movie), notice: 'Schedule was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @schedule.destroy
    redirect_to admin_movie_path(@movie), notice: 'Schedule was successfully destroyed.'
  end



  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def set_schedule
    @schedule = @movie.schedules.find(params[:id])
  end

  def schedule_params
    params.require(:schedule).permit(:start_time, :end_time)
  end


end
