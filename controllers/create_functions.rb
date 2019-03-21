#-------------------------------------------------------------------------------
# CREATE functions
#-------------------------------------------------------------------------------

def create_order
	
end

#-------------------------------------------------------------------------------

def create_tweet
    tweet_id = params[:in_reply_to_status_id].strip
    tweet_text = params[:reply].strip
	@twitter.update("#{tweet_text}", :in_reply_to_status_id => tweet_id)
end

#-------------------------------------------------------------------------------

def create_user # Kacper
    require 'digest'
    sha256 = Digest::SHA256.new

	#sanitize values
	display_name = params[:display_name].strip
	first_name = params[:first_name].strip
	surname = params[:surname].strip
	email = params[:email].strip
	password = params[:password].strip
    coded_password = Digest::SHA256.hexdigest password

	#perform validation
	display_name_ok = !display_name.nil? && display_name =~ VALID_TWITTER_HANDLE
	first_name_ok = !first_name.nil? && first_name != ""
	surname_ok = !surname.nil? && surname != ""
	email_ok = !email.nil? && email =~ VALID_EMAIL_REGEX
	# ...what about password?

	all_ok = display_name_ok && first_name_ok && surname_ok && email_ok

	if all_ok
		id = @db.get_first_value 'SELECT MAX(UserID)+1 FROM Userdetails;';
		success = @db.execute(
			'INSERT INTO Userdetails
			(UserID, Twitter_handle, Firstname, Surname, Email, Password)
			VALUES (?,?,?,?,?,?);',
			[id, display_name, first_name, surname, email, coded_password])
	end

	if success
		session[:display_name] = display_name
		session[:first_name] = first_name
		session[:surname] = surname
		session[:email] = email
		session[:user_login] = true

	else 
        redirect '/error'
	end
	
end

#-------------------------------------------------------------------------------