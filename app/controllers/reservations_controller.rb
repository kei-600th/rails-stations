class ReservationsController < ApplicationController

  before_action :authenticate_user!

  def new
    if params[:date].blank? || params[:sheet_id].blank?
      redirect_to movies_path
    else
      @reservation = Reservation.new(date: Date.parse(params[:date]), sheet_id: params[:sheet_id].to_i, schedule_id: params[:schedule_id].to_i)
  
      @reservation_movie_name = @reservation.schedule.movie.name
      @reservation_date = @reservation.date
      @reservation_sheet = "#{@reservation.sheet.row}-#{@reservation.sheet.column}"
      @reservation_schedule = "#{@reservation.schedule.start_time.strftime('%H:%M')}-#{@reservation.schedule.end_time.strftime('%H:%M')}"
    end
  end

  def create
    @reservation = Reservation.new(reservation_params)
  
    if @reservation.save
      redirect_to movies_path, notice: '予約が完了しました'
    else
      redirect_to reservation_movie_path(id: @reservation.schedule.movie.id, schedule_id: @reservation.schedule.id, date: @reservation.date)
    end
  
  end
  
  private
  
  def reservation_params
    params.require(:reservation).permit(:date, :schedule_id, :sheet_id, :email, :name)
  end


end
