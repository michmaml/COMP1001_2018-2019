#-------------------------------------------------------------------------------
# CREATE functions
#-------------------------------------------------------------------------------

def create_order # Toby

	orderID = params[:order_id].strip.to_i
	twitterHandle = params[:screen_name].strip

	date = params[:date].strip.to_i
	time = params[:time].strip.to_i
	pickupLocation = params[:pickup_location].strip.upcase
	carID = params[:car_id].strip.to_i
	
	valid = true
	[orderID,twitterHandle,date,time,pickupLocation,carID].each do |field|
		if field.nil? or field.to_s == "" then valid = false end
	end
	
	if valid
	
		# Not needed if we just use the tweet ID! Saves a call to db.
		#OrderID = @db.get_first_value('SELECT MAX(OrderID)+1 FROM Orders').to_i;

		# This can safely return zero for an unregistered customer...
		userID = @db.get_first_value(
			'SELECT UserID FROM User_details WHERE Twitter_handle = (?)',
			[twitterHandle]).to_i

		success = @db.execute(
			'INSERT INTO Orders
			(OrderID, CarID, UserID, Twitter_handle, Pickup_location, Date, Time, Status)
			VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
			[orderID, carID, userID, twitterHandle, pickupLocation, date, time, ORDER_STATUS_ACTIVE])
		
		if not success then redirect '/error' end
			
		create_tweet
		
	else
		redirect '/form_error'
	end
	
end

#-------------------------------------------------------------------------------

def create_tweet # Jamie
	
	tweet_id = @db.get_first_value 'SELECT MAX(TweetID)+1 FROM Tweets;'
	order_id = params[:order_id].strip.to_i
    reply = params[:reply].strip
	status = params[:status].strip.to_i

	@db.execute(
		"INSERT INTO Tweets (TweetID, OrderID, Status, Reply)
		VALUES (?, ?, ?, ?);",
		[tweet_id, order_id, status, reply])
	
	@twitter.update("#{reply}", :in_reply_to_status_id => order_id)

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
		id = @db.get_first_value 'SELECT MAX(UserID)+1 FROM User_details;'
		success = @db.execute(
			'INSERT INTO User_details
			(UserID, Twitter_handle, Firstname, Surname, Email, Password, Status)
			VALUES (?,?,?,?,?,?,?);',
			[id, display_name, first_name, surname, email, coded_password, USER_STATUS_ACTIVE])
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

def create_car # Ziting

  status = params[:Status].strip
  type = params[:Type].strip
  seats = params[:Seats].strip

    carID = @db.get_first_value('SELECT MAX(CarID)+1 FROM Cars')
 
     @db.execute('INSERT INTO Cars VALUES (?, ?, ?, ?)', [carID, status, type, seats])
    
end
		
def create_cartable # Ziting
	
    @Car = []
 
      query = "SELECT * FROM Cars;"
        
       @all = @db.execute query
#                 puts @cars.length
#                 puts params[:search].to_i
    if @all
        @all.each do |car|
			@Car.push({

				CarID: car["CarID"].to_s,
				Status: car["Status"].to_s,
				Type: car["Type"].to_s,
				Seats: car["Seats"].to_s,

			})
		end
        return @all

	else
		redirect '/error'
    end
end

#-------------------------------------------------------------------------------

def add_cars(type,seats)  #Adds a new car to system status is automatically set to 0                #works 
  if type.is_a?(Integer) && seats.is_a?(Integer)
    carID = @db.get_first_value('SELECT MAX(CarID)+1 FROM Cars');
      #puts carID[0]
    #puts carID, type ,seats
    query = @db.execute(
      'INSERT INTO Cars VALUES (?, ?, ?, ?)',
      [carID, 0, type, seats])
    return query
  else
      puts "invalid data types"
  end
end