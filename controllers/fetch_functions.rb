#-------------------------------------------------------------------------------
# FETCH functions
#-------------------------------------------------------------------------------

def fetch_orders # Michal
	
	# Just for example...
	display_name = "realDonaldTrump"
	

	#unless params[:search].nil?
	
		@orders = []

		query = "SELECT * FROM Orders LIMIT 20;"
		@results = @db.execute query

		if @results
			
			@results.each do |order|
				@orders.push({

					date: order["Date"].to_s,
					time: order["Time"].to_s,
					from: order["Pickup_location"].to_s,
					to: "unknown",

					id: order["OrderID"].to_s,
					screen_name: "test",
					
# TODO: connect the following property to tweeted orders stored in the database!
					tweets: @twitter.user_timeline(display_name).take(10)
					
				})
			end

		else redirect error
		end
	#end
end

#-------------------------------------------------------------------------------

def fetch_tweets # Michal
	
	results = @twitter.search(SEARCH_STRING)
	@tweets = results.take(20)

end

#-------------------------------------------------------------------------------

def fetch_users
	
end

#-------------------------------------------------------------------------------