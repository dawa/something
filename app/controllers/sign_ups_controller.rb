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
	@sign_up.ip_address = request.remote_ip
    @sign_up.user_agent = request.env["HTTP__AGENT"]
    @sign_up.referer = @referer
  end

  # POST /sign_ups
  # POST /sign_ups.xml
  def create
    @sign_up = SignUp.new(params[:sign_up])

    respond_to do |format|
      if @sign_up.save
        #format.html { redirect_to(:thanks, :notice => 'Sign up was successful.') }
        redirect_to :thanks
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sign_up.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def thanks
    format.html # index.html.erb
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
end
