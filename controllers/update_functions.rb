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