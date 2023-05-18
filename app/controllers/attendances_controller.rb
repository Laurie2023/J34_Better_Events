class AttendancesController < ApplicationController
  #before_action :admin_user

  def index
    @all_attendances = Attendance.all
  end

  def show
    @attendance = Attendance.find(params[:id].to_i)
  end 

  private
    def admin_user
      @all_attendances = Attendance.all
      unless current_user.id == Event.find(@all_attendances.first.event_id).admin_id
        redirect_to events_path(connexion_obligatoire:true)
      end
    end
end
