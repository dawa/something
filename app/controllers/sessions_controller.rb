class SessionsController < ApplicationController
  skip_before_filter :authorize
    
  def new
    #flash.now[:alert] = "Here"
  end

  def create
    if admin = Admin.authenticate(params[:name], params[:password]) 
	  session[:admin_id] = admin.id 
	  redirect_to admins_url, :notice => "Logged in successfully" 
	else 
	  flash.now[:alert] = "Invalid user/password combination"
	  render :action => 'new'
	end 
  end

  def destroy
	#session[:admin_id] = nil 
	reset_session
	redirect_to root_path, :notice => "Logged out" 
  end

end
