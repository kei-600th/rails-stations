class Admin::MoviesController < ApplicationController

  def index
    @movies = Movie.all
    
    # @movies内の各映画のIDを抽出し、配列化します
    # 抽出した映画IDを使用して、Scheduleモデルのレコードを検索し、@schedulesに代入します
    # これにより、@schedulesは指定された映画に関連するスケジュールのコレクションとなります
    @schedules = Schedule.where(movie_id: @movies.map(&:id))
  end


  def new
    @movie = Movie.new
  end

  def show
    @movie = Movie.includes(:schedules).find(params[:id])
    @cinemas = Cinema.all
  end

  def create
    @movie = Movie.new(movie_params)
  
    if @movie.save
      redirect_to "/"
    else
      render :new
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update(movie_params)
      redirect_to "/"
    else
      render :edit
    end
  end

  def destroy

    @movie = Movie.find(params[:id])

    @movie.delete
    redirect_to "/"
  end

  private

  def movie_params
    params.require(:movie).permit(:name, :year, :description, :image_url, :is_showing)
  end
  
end
