#-------------------------------------------------------------------------------
# LOGIN functions
#-------------------------------------------------------------------------------

def log_in # Kacper
	
	require 'digest'
    sha256 = Digest::SHA256.new

	#sanitize values
	
	email = params[:email].strip
	password = params[:password].strip
    coded_password = Digest::SHA256.hexdigest password

	#perform validation
    status = @db.get_first_value(
		'SELECT Status FROM User_details WHERE Email = ? AND Password = ?;',[email, coded_password]
	).to_i
	
	if status >= USER_STATUS_ADMIN
		session[:admin_login] = true
	end
	
	if status >= USER_STATUS_ACTIVE
		session[:user_login] = true
        session[:email] = email
    else
		session[:admin_login] = false
		session[:user_login] = false
		session[:email] = email
		redirect '/not_authorised'
    end
	
end

#-------------------------------------------------------------------------------

def log_out # Jamie
	
	session.clear
	
end

#-------------------------------------------------------------------------------