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

def fetch_users # Lee
	@users = []
    
    query = "SELECT UserID, Firstname, Surname, Twitter_handle, Email, Reward_points, Status, Total_orders, Total_cancellations FROM User_details;"
    results = @db.execute query

	if results
		results.each do |user|
            
            @users.push({
                
                userid: user["UserID"],
                firstname: user["Firstname"],
                surname: user["Surname"],
                twitter_handle: user["Twitter_handle"],
                email: user["Email"],
                reward_points: user["Reward_points"],
                status: user["Status"],
                total_orders: user["Total_orders"],
                total_cancellations: user["Total_cancellations"],
			})
			
		end

	else
		redirect '/error'
	end

end

def fetch_user_orders # Lee
	
	@orders = []

	query = "SELECT * FROM Orders WHERE UserID = #{session[:id]} LIMIT 20;"
	results = @db.execute query

	if results
		results.each do |order|
			

			@orders.push({

				date: order["Date"],
				time: order["Time"],
				from: order["Pickup_location"],
				to: nil,
				car_id: order["CarID"],

				id: order["OrderID"],
				user_id: order["UserID"],
				screen_name: order["Twitter_handle"],

			})
			
		end

	else
		redirect '/error'
	end

end

def search_by_userid(user_id)         #Searches for a user id and displays information on that user   #works
  @users = []
    query = %{ SELECT UserID, Firstname, Surname, Twitter_handle, Email, Reward_points, Status, Total_orders, Total_cancellations
        FROM User_details 
        WHERE UserID Like '%' || ? || '%'}
    results = @db.execute query, user_id
      if results
		results.each do |user|
			

			@users.push({
                
                userid: user["UserID"],
                firstname: user["Firstname"],
                surname: user["Surname"],
                twitter_handle: user["Twitter_handle"],
                email: user["Email"],
                reward_points: user["Reward_points"],
                status: user["Status"],
                total_orders: user["Total_orders"],
                total_cancellations: user["Total_cancellations"],
			})

			
			
		end
      end
end




#-------------------------------------------------------------------------------