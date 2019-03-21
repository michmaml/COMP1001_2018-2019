#-------------------------------------------------------------------------------
# CREATE functions
#-------------------------------------------------------------------------------

def create_order # Toby

	orderID = params[:orderID].strip.to_i
	userName = params[:userName].strip
	userScreenName = params[:userScreenName].strip
	createdAt = params[:createdAt].strip
	text = params[:text].strip
	
	date = params[:date].strip.to_i
	time = params[:time].strip.to_i
	pickup_location = params[:pickup_location].strip.upcase
	carID = params[:carID].strip.to_i
	
	valid = true
	[orderID,userName,userScreenName,createdAt,text,date,time,pickup_location,carID].each do |field|
		if field.nil? or field.to_s == "" then valid = false end
	end
	
	if valid
	
		# Not needed if we just use the tweet ID! Saves a call to db.
		#OrderID = @db.get_first_value('SELECT MAX(OrderID)+1 FROM Orders').to_i;

		userID = @db.get_first_value(
			'SELECT UserID FROM User_details WHERE Twitter_handle = (?)',
			[userScreenName]).to_i

		success = @db.execute(
			'INSERT INTO Orders
			(OrderID, CarID, UserID, Pickup_location, Date, Time, Status)
			VALUES (?, ?, ?, ?, ?, ?, ?)',
			[orderID, carID, userID, pickup_location, date, time, ORDER_STATUS_ACTIVE])

		# puts UserID,Date,Time,Pickup_location
		
		if not success then redirect '/error' end
		
	else
		redirect '/form_error'
	end
	
end

#-------------------------------------------------------------------------------

def create_tweet
	
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

	all_ok = display_name_ok && first_name_ok && surname_ok && email_ok

	if all_ok
		id = @db.get_first_value 'SELECT MAX(UserID)+1 FROM User_details;';
		success = @db.execute(
			'INSERT INTO User_details
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