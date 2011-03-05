class Notifier < ActionMailer::Base
  default :from => "alpha@flickme.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.email_alpha.subject
  #
  def email_alpha(sign_up)
    @greeting = "Welcome to FlickMe"
    @sign_up = sign_up
	@sender_name = "FlickMe Alpha"
	
    mail :to => @sign_up.email, :subject => @greeting, :reply_to => "no_reply@flickme.com"
  end
end
