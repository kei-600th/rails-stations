namespace :remind_reservations do
  desc "Send reminders to customers who have reservations tomorrow"
  task send_reminders: :environment do
    reservations = Reservation.where(date: Date.current + 1.day)

    reservations.each do |reservation|
      ReservationMailer.reservation_reminder(reservation).deliver_now
    end
  end
end
