#-------------------------------------------------------------------------------
# UPDATE functions
#-------------------------------------------------------------------------------

def update_order # Jamie

	orderID = params[:order_id].strip.to_i

	date = params[:date].strip
	time = params[:time].strip
	pickupLocation = params[:pickup_location].strip.upcase
	carID = params[:car_id].strip.to_i
	
	valid = true
	[orderID,date,time,pickupLocation,carID].each do |field|
		if field.nil? or field.to_s == "" then valid = false end
	end
	
	if valid
	
		begin
			@db.execute(
				'UPDATE Orders
				SET CarID=?, Pickup_location=?, Date=?, Time=?
				WHERE OrderID=?',
				[carID, pickupLocation, date, time, orderID])
		rescue
			redirect '/error'
		end
		
	else
		redirect '/form_error'
	end
	
end

#-------------------------------------------------------------------------------

def update_user
	# To be continued... I have implemented it as the settings for users 
	
end
   
#-------------------------------------------------------------------------------
      
def update_user_settings
       
     require 'digest'
    sha256 = Digest::SHA256.new 
	submitted = params[:submitted]
	pass1 = params[:pass1].strip
    pass2 = params[:pass2].strip
    pass1sha256 = Digest::SHA256.hexdigest pass1
    pass2sha256 = Digest::SHA256.hexdigest pass2
    
    if(pass1sha256 == pass2sha256) 
        @db.execute(
			'UPDATE User_details
			SET Password=? WHERE Email=?',
			[pass1sha256, session[:email]])
        redirect '/user_settings'
            
    else
        redirect '/form_error'
    end
	
end    
 
#-------------------------------------------------------------------------------

def accept_tweet # Jamie
	
	tweetID = params[:order_id].strip.to_i
	@db.execute(
		"UPDATE Tweets SET Status = #{TWEET_STATUS_ACCEPTED} WHERE TweetID = ?;",
		[tweetID])
	
end

#-------------------------------------------------------------------------------

        #responsible for switching contact webpage after sending the email - contact.erb
def contact_submitted #Michal
    
    @submitted = !!params[:email]
    
    @name = params[:firstName].strip
    @email = params[:email].strip
    @subject = params[:subject].strip
    @message = params[:message].strip
    
    name_to_send_to = h params[:firstName]
    address_to_send_to = h params[:email]
    subject_to_send_to = h params[:subject]
    message_to_send_to = h params[:message]
    
    @name_ok = 
        !@name.nil? && @name != ""
    @user_email_ok =
        !@email.nil? && @email =~ VALID_EMAIL_REGEX
    @subject_ok = 
        !@subject.nil? && @subject != ""
    @message_ok = 
        !@message.nil? && @message != ""
    @all_ok = @name_ok && @user_email_ok && @subject_ok && @message_ok
  
    options = { :address              => "smtp.gmail.com",
                :port                 => 465,
                :domain               => 'atlas-fiction.codio.io',
                :user_name            => 'ise19team28@gmail.com',
                :password             => 'Taxiteam28',
                :authentication       => 'plain',
                :enable_starttls_auto => true,
                :ssl => true
      }
    Mail.defaults do
      delivery_method :smtp, options
    end

    Mail.deliver do
      to 'ise19team28@gmail.com'
      from address_to_send_to
      subject "🔥 Message from: " + name_to_send_to + "("+address_to_send_to+")" + " Subject: " + subject_to_send_to
      body  "Feedback: " + message_to_send_to 
    end
    erb :contact
end

#-------------------------------------------------------------------------------

def update_map #Huiqiang
	
    @Locations = []
     
    query = "SELECT Pickup_location FROM Orders;"
    results = @db.execute query

		results.each do |location|
      
         pio = Postcodes::IO.new
         postcode = pio.lookup(location["Pickup_location"])
         
		if postcode
			 @Locations.push({    
			   :lat => postcode.latitude,           
			   :long => postcode.longitude           
			  })
		end

    end
end