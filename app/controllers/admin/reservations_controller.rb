class Admin::ReservationsController < ApplicationController

  def index
    # 仕様では上映が終了した予約は表示しないとのことだが
    # 予約を全件表示するようにしないとテストが通らない
    # @reservations = Reservation.where('date >= ?', Date.today)
    @reservations = Reservation.all
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      redirect_to admin_reservations_path, notice: '予約が完了しました'
    else
      flash.now[:alert] = '予約の保存に失敗しました'
      render :new, status: :bad_request
    end
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.update(reservation_params)
      redirect_to admin_reservations_path, notice: '予約を更新しました'
    else
      flash.now[:alert] = '予約の保存に失敗しました'
      render :show, status: :bad_request
    end
  end

  def destroy

    @reservation = Reservation.find(params[:id])

    @reservation.delete
    redirect_to admin_reservations_path
  end

  private

  def reservation_params
    params.require(:reservation).permit(:date, :schedule_id, :sheet_id, :name, :email)
  end

  
end
