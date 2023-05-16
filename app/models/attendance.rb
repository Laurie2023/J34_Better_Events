class Attendance < ApplicationRecord
  belongs_to :user
  belongs_to :event

  after_create :registration_send

  def registration_send
    AttendanceMailer.registration_email(self).deliver_now
    #AttendanceMailer.registration_email.deliver_now
  end
end
