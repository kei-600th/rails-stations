class ReservationMailer < ApplicationMailer
  def reservation_completed(reservation)
    @reservation = reservation
    mail(to: @reservation.email, subject: '予約が完了しました')
  end

  def reservation_reminder(reservation)
    @reservation = reservation
    mail(to: @reservation.email, subject: '予約リマインダー')
  end
end
