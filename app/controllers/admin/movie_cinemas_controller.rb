class Admin::MovieCinemasController < ApplicationController

  def create
    @movie_cinema = MovieCinema.new(movie_cinema_params)

    if @movie_cinema.save
      redirect_to madmin_movie_path(@movie_cinema.movie)
    else
      redirect_to admin_movie_path(@movie_cinema.movie)
    end
  end

  def show
    @movie_cinema = MovieCinema.find(params[:id])
  end

  def destroy
  end




  private

  def movie_cinema_params
    params.permit(:movie_id, :cinema_id)
  end


end
