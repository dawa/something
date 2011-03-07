class ApplicationController < ActionController::Base
  before_filter :authorize
  protect_from_forgery
  helper_method :current_admin
  
  protected

    def authorize
      unless Admin.find_by_id(session[:admin_id])
        redirect_to login_url, :notice => "Please log in"
      end
    end

  private
  
	def current_admin
	  @current_admin ||= Admin.find_by_id(session[:admin_id]) if session[:admin_id]
	end
end
