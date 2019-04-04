#-------------------------------------------------------------------------------
# UPDATE functions
#-------------------------------------------------------------------------------

def update_order # Jamie

	orderID = params[:order_id].strip.to_i

	date = params[:date].strip.to_i
	time = params[:time].strip.to_i
	pickupLocation = params[:pickup_location].strip.upcase
	carID = params[:car_id].strip.to_i
	
	valid = true
	[orderID,date,time,pickupLocation,carID].each do |field|
		if field.nil? or field.to_s == "" then valid = false end
	end
	
	if valid
	
		success = @db.execute(
			'UPDATE Orders
			SET CarID=?, Pickup_location=?, Date=?, Time=?
			WHERE OrderID=?',
			[carID, pickupLocation, date, time, orderID])
		
		if not success then redirect '/error' end
		
	else
		redirect '/form_error'
	end
	
end

#-------------------------------------------------------------------------------

def update_user
	
	# To be continued...
	
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
