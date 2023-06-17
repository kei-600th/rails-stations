class ApplicationController < ActionController::Base

  private

  def check_if_admin
    unless current_user && current_user.admin?
      redirect_to "/", alert: "You must be an admin to access this page."
    end
  end

end
