#-------------------------------------------------------------------------------
# LOGIN functions
#-------------------------------------------------------------------------------

def log_in
	
	require 'digest'
    sha256 = Digest::SHA256.new

	#sanitize values
	
	email = params[:email].strip
	password = params[:password].strip
    coded_password = Digest::SHA256.hexdigest password

	#perform validation
    number_one = @db.get_first_value('SELECT COUNT(*) FROM Userdetails WHERE Email = ? AND Password = ?;',[email, coded_password])
	if number_one == 1
		session[:admin_login] = true
		session[:user_login] = true 
    else
            session[:admin_login] = false
            session[:user_login] = false
            session[:email] = email
            redirect '/not_authorised'
    end
	
end

#-------------------------------------------------------------------------------

def log_out
	session[:admin_login] = false
	session[:user_login] = false
end

#-------------------------------------------------------------------------------