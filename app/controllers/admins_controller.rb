class AdminsController < ApplicationController  
  skip_before_filter :authorize, :only => [:new, :create]
  
  # GET /admins
  # GET /admins.xml
  def index
    @admins = Admin.order(:name)
	@total_sign_ups= SignUp.count
	
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admins }
    end
  end

  # GET /admins/1
  # GET /admins/1.xml
  def show
    @admin = Admin.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @admin }
    end
  end

  # GET /admins/new
  # GET /admins/new.xml
  def new
    @admin = Admin.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @admin }
    end
  end

  # GET /admins/1/edit
  def edit
    @admin = Admin.find(params[:id])
  end

  # POST /admins
  # POST /admins.xml
  def create
    @admin = Admin.new(params[:admin])

    respond_to do |format|
      if @admin.save
        format.html { redirect_to(admins_url, :notice => "Admin #{@admin.name} was successfully created.") }
        format.xml  { render :xml => @admin, :status => :created, :location => @admin }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @admin.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admins/1
  # PUT /admins/1.xml
  def update
    @admin = Admin.find(params[:id])

    respond_to do |format|
      if @admin.update_attributes(params[:admin])
        format.html { redirect_to(admins_url, :notice => "Admin #{@admin.name} was successfully updated.") }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @admin.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/1
  # DELETE /admins/1.xml
  def destroy
    @admin = Admin.find(params[:id])
    begin
      @admin.destroy
      flash[:notice] = "Admin #{@admin.name} deleted"
    rescue Exception => e
      flash[:notice] = e.message
    end

    respond_to do |format|
      format.html { redirect_to(admins_url) }
      format.xml  { head :ok }
    end
  end
end
