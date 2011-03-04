class AdminController < ApplicationController
  def index
	@total_sign_ups= SignUp.count
	@sign_ups = SignUp.all
  end

end
