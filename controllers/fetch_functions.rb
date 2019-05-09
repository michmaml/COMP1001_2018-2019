#-------------------------------------------------------------------------------
# FETCH functions
#-------------------------------------------------------------------------------

def fetch_orders # Jamie
	
	results = @db.execute (
		"SELECT * FROM Orders WHERE Status = #{ORDER_STATUS_ACTIVE} ORDER BY OrderID DESC LIMIT 20;"
		)

	if results

		@orders = []
		results.each do |order|
			
			tweet_list = @db.execute(
				"SELECT * FROM Tweets WHERE TweetID = ? OR OrderID = ? ORDER BY TweetID ASC",
				[order["OrderID"], order["OrderID"]])
			tweets = []
			tweet_list.each do |tweet|
				tweets.push(tweet[0])
			end
			
			@orders.push({
				
				date: order["Date"],
				time: order["Time"],
				from: order["Pickup_location"],
				to: nil,
				car_id: order["CarID"],

				id: order["OrderID"],
				user_id: order["UserID"],
				screen_name: order["Twitter_handle"],
				
				tweets:	@twitter.statuses(tweets)
			})
		end

	else
		redirect '/error'
	end

end

#-------------------------------------------------------------------------------

def fetch_tweets # Jamie

	# Update list of tweets in database from Twitter API	
	new_tweets = @twitter.mentions_timeline
	new_tweets.each do |tweet|
		tweet_id = tweet.id.to_i
		order_id = tweet.in_reply_to_status_id.to_i    # usefully returns 0 if not set...
		status = TWEET_STATUS_NEW
		# Try (or begin, in this case!) to add to database; allow failure if already exists
		begin
			@db.execute(
				"INSERT INTO Tweets (TweetID, OrderID, Status) VALUES (?, ?, ?);",
				[tweet_id, order_id, status])
		rescue
		end
	end
	
	# Filter the following Twitter API search by the status of tweet IDs stored in the database!
	# If OrderID = 0, then the tweet is an original post (start of a thread),
	# else OrderID = the ID of the original post it is in reply to
	tweet_list = @db.execute(
		"SELECT TweetID FROM Tweets WHERE OrderID=0 AND Status=#{TWEET_STATUS_NEW}
		ORDER BY TweetID DESC LIMIT 20;")
	tweets = []
	tweet_list.each do |tweet|
		tweets.push(tweet[0])
	end
	@tweets = @twitter.statuses(tweets)
	
end

#-------------------------------------------------------------------------------

def fetch_users # Huiqiang
	
    user_id = params[:user_id]
    results = @db.execute(
		"SELECT pickup_location, date, time FROM Orders WHERE UserID = ?;",
		[user_id])
    

end

#-------------------------------------------------------------------------------

def fetch_cars 
	@Car = []
 
    query = "SELECT * FROM Cars;"
        
    @cars = @db.execute query
    #puts @cars.length

    if @cars
        @cars.each do |car|
			@Car.push({

				CarID: car["CarID"].to_s,
				Status: car["Status"].to_s,
				Type: car["Type"].to_s,
				Seats: car["Seats"].to_s,
                Location: car["Location"].to_s,

			})
		end

        return @Car

	else
		redirect '/error'
    end
end


#-------------------------------------------------------------------------------