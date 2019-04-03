#-------------------------------------------------------------------------------
# FETCH functions
#-------------------------------------------------------------------------------

def fetch_orders # Jamie
	
	@orders = []

	query = "SELECT * FROM Orders WHERE Status = #{ORDER_STATUS_ACTIVE} LIMIT 20;"
	results = @db.execute query

	if results

		results.each do |order|
			
=begin
			# Ideally we would fetch all the tweets that have replied to the original...
			
			tweet_list = @db.execute(
					"SELECT TweetID, Reply FROM Tweets
					WHERE OrderID = ? AND Status = ?;",
					[order["OrderID"], TWEET_STATUS_ACCEPTED])
			tweets = []
			tweet_list.each do |tweet|
				tweets.push(@twitter.status(tweet["OrderID"]))
			end
=end
			@orders.push({

				date: order["Date"],
				time: order["Time"],
				from: order["Pickup_location"],
				to: nil,
				car_id: order["CarID"],

				id: order["OrderID"],
				user_id: order["UserID"],
				screen_name: order["Twitter_handle"],

				tweets: @twitter.search("from:#{order["Twitter_handle"]} @#{TEAM_NAME}")
				
				# Obsolete...
				#@twitter.search("from:#{order["Twitter_handle"]} @#{TEAM_NAME}")
			})
			
		end

	else
		redirect '/error'
	end

end

#-------------------------------------------------------------------------------

def fetch_tweets # Michal

# TODO: filter the following Twittter API search by the status of tweet IDs stored in the database!
	results = @twitter.mentions_timeline()
	@tweets = results.take(20)

end

#-------------------------------------------------------------------------------

def fetch_users # Huiqiang
	
    user_id = params[:user_id]
    results = @db.execute(
		"SELECT pickup_location, date, time FROM Orders WHERE UserID = ?;",
		[user_id])

end

#-------------------------------------------------------------------------------