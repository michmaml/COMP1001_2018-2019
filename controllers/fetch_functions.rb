#-------------------------------------------------------------------------------
# FETCH functions
#-------------------------------------------------------------------------------

def fetch_orders # Michal
	
	@orders = []

	query = "SELECT * FROM Orders LIMIT 20;"
	@results = @db.execute query

	if @results

		@results.each do |order|
			@orders.push({

                orderID: order["OrderID"].to_s,#Toby
				date: order["Date"].to_s,
				time: order["Time"].to_s,
				from: order["Pickup_location"].to_s,
				to: "unknown",

				id: order["OrderID"].to_s,
				screen_name: "test",

# TODO: connect the following property to tweeted orders stored in the database!
				tweets: @twitter.user_timeline(SEARCH_STRING).take(10)

			})
		end

	else
		redirect error
	end

end

#-------------------------------------------------------------------------------

def fetch_tweets # Michal
	
	results = @twitter.search(SEARCH_STRING)
	@tweets = results.take(10)

end

#-------------------------------------------------------------------------------

def fetch_users
	
end

#-------------------------------------------------------------------------------