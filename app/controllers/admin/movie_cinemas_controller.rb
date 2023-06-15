class Admin::MovieCinemasController < ApplicationController

  def create
    @movie_cinema = MovieCinema.new(movie_cinema_params)

    if @movie_cinema.save
      redirect_to admin_movie_path(@movie_cinema.movie)
    else
      redirect_to admin_movie_path(@movie_cinema.movie)
    end
  end

  def show
    @movie_cinema = MovieCinema.find(params[:id])
  end

  def destroy
    @movie_cinema = MovieCinema.find(params[:id])
    if @movie_cinema.destroy
      flash[:notice] = '映画館での上映が正常に削除されました'
    else
      flash[:alert] = '映画館での上映を削除することができませんでした'
    end
    redirect_to admin_movie_path(@movie_cinema.movie)
  end




  private

  def movie_cinema_params
    params.permit(:movie_id, :cinema_id)
  end


end
