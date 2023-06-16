class ReservationMailer < ApplicationMailer
  def reservation_completed(reservation)
    @reservation = reservation
    mail(to: @reservation.email, subject: '予約が完了しました')
  end
end
