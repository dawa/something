class SignUp < ActiveRecord::Base
  validates :email, :presence => true,
					:uniqueness => true, 
                    :length => { :within => 5..50 }, 
                    :format => { :with => /^[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}$/i }
  
end
