#-------------------------------------------------------------------------------
# FETCH functions
#-------------------------------------------------------------------------------

def fetch_orders # Michal
	
	@orders = []

	query = "SELECT * FROM Orders WHERE Status = #{ORDER_STATUS_ACTIVE} LIMIT 20;"
	results = @db.execute query

	if results

		results.each do |order|

			@orders.push({

				date: order["Date"].to_s,
				time: order["Time"].to_s,
				from: order["Pickup_location"].to_s,
				to: nil,

				id: order["OrderID"].to_s,
				user_id: order["UserID"].to_s,
				screen_name: order["Twitter_handle"],

# TODO: connect the following property to tweeted orders stored in the database!
				tweets: @twitter.search("from:#{order["Twitter_handle"]} to:#{TEAM_NAME}").take(100)

			})
		end

	else
		redirect '/error'
	end

end

#-------------------------------------------------------------------------------

def fetch_tweets # Michal
	
	results = @twitter.search(TEAM_NAME)
	@tweets = results.take(10)

end

#-------------------------------------------------------------------------------
def fetch_cars 
# 	(%{SELECT * FROM Cars WHERE Seats = ?})
	@Car = []
 
      query = "SELECT * FROM Cars WHERE Type = ?;"
        
       @cars = @db.execute query,params[:Type].to_i
#                 puts @cars.length
#                 puts params[:search].to_i
    if @cars
        @cars.each do |car|
			@Car.push({

				CarID: car["CarID"].to_s,
				Status: car["Status"].to_s,
				Type: car["Type"].to_s,
				Seats: car["Seats"].to_s,

			})
		end
        return @cars

	else
		redirect error
    end
end
#-------------------------------------------------------------------------------

def fetch_users # Huiqiang
	
    user_id = params[:screen_name]
    @results = @db.execute(
		"SELECT pickup_location, date, time FROM Orders WHERE UserID = ?;",
		[user_id])

end

#-------------------------------------------------------------------------------