#-------------------------------------------------------------------------------
# CREATE functions
#-------------------------------------------------------------------------------

def create_order # Toby
	
	orderID = params[:order_id].strip.to_i
	twitterHandle = params[:screen_name].sub('@','').strip

	date = params[:date].strip
	time = params[:time].strip
	pickupLocation = params[:pickup_location].strip.upcase
	carID = params[:car_id].strip.to_i
	
	valid = true
	[orderID,twitterHandle,date,time,pickupLocation,carID].each do |field|
		if field.nil? or field.to_s == "" then valid = false end
	end
	
	if valid
		begin
			create_tweet
			accept_tweet
			
			# This can safely return zero for an unregistered customer...
			userID = @db.get_first_value(
				'SELECT UserID FROM User_details WHERE Twitter_handle = (?)',
				[twitterHandle]).to_i

			success = @db.execute(
				'INSERT INTO Orders
				(OrderID, CarID, UserID, Twitter_handle, Pickup_location, Date, Time, Status)
				VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
				[orderID, carID, userID, twitterHandle, pickupLocation, date, time, ORDER_STATUS_ACTIVE])		
		rescue
			redirect '/error'
		end
		
	else
		redirect '/form_error'
	end
	
end

#-------------------------------------------------------------------------------

def create_tweet # Jamie

	order_id = params[:order_id].strip.to_i
    reply = params[:reply].strip
	begin
		@twitter.update("#{reply}", :in_reply_to_status_id => order_id)
		@db.execute(
			"UPDATE Tweets SET Reply = ? WHERE TweetID = ?;",
			[reply, order_id])
	rescue
		redirect '/form_error'
	end
	
end

#-------------------------------------------------------------------------------
	
def create_user # Kacper
	
    require 'digest'
    sha256 = Digest::SHA256.new

	#sanitize values
	display_name = params[:display_name].sub('@','').strip
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
		begin
			id = @db.get_first_value 'SELECT MAX(UserID)+1 FROM User_details;'
			@db.execute(
				'INSERT INTO User_details
				(UserID, Twitter_handle, Firstname, Surname, Email, Password, Status)
				VALUES (?,?,?,?,?,?,?);',
				[id, display_name, first_name, surname, email, coded_password, USER_STATUS_ACTIVE])

			session[:display_name] = display_name
			session[:first_name] = first_name
			session[:surname] = surname
			session[:email] = email
			session[:user_login] = true
		rescue
			redirect '/signup_error'
		end
	else
		redirect '/form_error'
	end
	
end

#-------------------------------------------------------------------------------

def add_cars(type,seats,location)  #Adds a new car to system status is automatically set to 0   #works 
  if type.is_a?(Integer) && seats.is_a?(Integer)
    carID = @db.get_first_value('SELECT MAX(CarID)+1 FROM Cars');
    query = @db.execute(
      'INSERT INTO Cars VALUES (?, ?, ?, ?,?)',
      [carID, 0, type, seats, location.capitalize])
    return query
  else
      redirect '/form_error'
  end
end
        
#-------------------------------------------------------------------------------

def add_favourite     # Kacper
	
    favourite_place = params[:place].strip
	
	userID = @db.get_first_value(
		'SELECT UserID FROM User_details WHERE Email = (?)',
		[session[:email]])
	
    favouritesID = @db.get_first_value(
		'SELECT MAX(FavouritesID)+1 FROM Favourites')
	
    @db.execute('INSERT INTO Favourites VALUES (?,?,?)',
		[favouritesID, userID, favourite_place])
end