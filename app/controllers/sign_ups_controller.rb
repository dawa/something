class SignUpsController < ApplicationController
  skip_before_filter :authorize, :only => [ :new, :create, :thanks ]
  
  # GET /sign_ups
  # GET /sign_ups.xml
  def index
    @sign_ups = SignUp.all
	@referer = request.env['HTTP_REFERER']
  end

  # GET /sign_ups/new
  # GET /sign_ups/new.xml
  def new
    @sign_up = SignUp.new
  end

  # POST /sign_ups
  # POST /sign_ups.xml
  def create
    @sign_up = SignUp.new(params[:sign_up])
	@referer ||= request.env['HTTP_REFERER']
	@sign_up.ip_address = request.remote_ip
    @sign_up.user_agent = request.env['HTTP_USER_AGENT']
    @sign_up.referer = @referer

    respond_to do |format|
      if @sign_up.save
        format.html { render :action => "thanks", :notice => 'Sign up was successful.' }
        #redirect_to :thanks
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sign_up.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def thanks
  end

  def alpha_sent
  end
  
  # DELETE /sign_ups/1
  # DELETE /sign_ups/1.xml
  def destroy
    @sign_up = SignUp.find(params[:id])
    @sign_up.destroy

    respond_to do |format|
      format.html { redirect_to(sign_ups_url) }
      format.xml  { head :ok }
    end
  end
  
  def notify?
    @sign_up = SignUp.find(params[:id])
	return @sign_up.notified==0
  end
  
  def notify_alpha
    @sign_up = SignUp.find(params[:id])
	
	Notifier.email_alpha(@sign_up).deliver
    
	#Assumming email was successfully sent so can update user state
	@sign_up.notified = 1

	respond_to do |format|
      if @sign_up.save
	    format.html { render :action => "alpha_sent", :notice => "Successfully sent notice to alpha user" }
        format.xml  { head :ok }
	  else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sign_up.errors, :status => :unprocessable_entity }
      end
    end
  end
end
