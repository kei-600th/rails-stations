class MoviesController < ApplicationController

  before_action :authenticate_user!, except: [:show, :index]

  def index
    @movies = Movie.all
    if params[:is_showing].present?
      @movies = @movies.where(is_showing: params[:is_showing])
    end
    if params[:keyword].present?
      @movies = @movies.where('name LIKE ? OR description LIKE ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
    end

    @rankings = Ranking.where(date: Date.today)
  end

  def show
    @movie = Movie.includes(movie_cinemas: :schedules).find(params[:id])
    @available_movie_cinemas = @movie.movie_cinemas.select do |movie_cinema|
      movie_cinema.schedules.present?
    end
  end

  def reservation
    if params[:date].blank? || params[:schedule_id].blank?
      redirect_to movies_path
    else
      @sheets = Sheet.all
      @date = params[:date]
      @schedule = Schedule.find(params[:schedule_id])
      @movie = @schedule.movie_cinema.movie

      @booked_reservations = @schedule.reservations.where(date: @date)
      @booked_reservations_sheet_ids = @booked_reservations.pluck(:screen_sheet_id)
      test
    end
  end

  def show_schedules
    @movie_cinema = MovieCinema.find(params[:movie_cinema_id])
    @dates = (Date.today..Date.today + 6.days).to_a
  end




  #複雑なメソッド
  def test
    @candidate_screen_sheets = []
    @sheets.each do |sheet|
      screen_sheets = ScreenSheet.where(sheet_id: sheet.id)
      screen_sheets.each do |screen_sheet|
          # 座席に対してスクリーン1,2,3全て予約済みだったらbreak
        if count_sheets(sheet) == 3
          @candidate_screen_sheets.push("予約不可")
          break
        end
        # 該当のスクリーンが予約されていなければbreak
        unless is_screen_reserved?(screen_sheet)
          @candidate_screen_sheets.push(screen_sheet)
          break
        end
      end
    end
  end

  # シートidが一致しているものの数を数える
  def count_sheets(sheet)
    count = 0
    @booked_reservations.each do |reservation|
      screen_sheet = ScreenSheet.find(reservation.screen_sheet_id)
      if screen_sheet.sheet_id == sheet.id
        count += 1
      end
    end
    count
  end

  def is_screen_reserved?(screen_sheet)
    @booked_reservations.any? { |reservation| reservation.screen_sheet_id == screen_sheet.id }
  end






  #showアクションを消してreservationアクションを追加する

end
