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

def upload_tweets_to_db # Michal

get '/add' do
    @submitted = false
erb :add
end

post '/add' do
    @submitted = true
  # sanitize values
      @date = order[:date].strip
      @time = order[:time].strip
      @from = order[:from].strip
      @to = order[:to].strip
     #@car = order[:car].strip
     #@OrderID = 
     @UserID ={user.screen_name} 
    # get next available ID
    id = @db.get_first_value 'SELECT MAX(id)+1 FROM Orders';

    # do the insert
    @db.execute(
      'INSERT INTO cities VALUES (?, ?, ?, ?, ?)',
      [id, @from, @date, @time, @to])
    
     #'INSERT INTO cities VALUES (?, ?, ?, ?, ?, ?)',
     #[OrderID,@CarID,@UserID, @from, @date, @time])
    end
end

#-------------------------------------------------------------------------------

def fetch_tweets # Michal
	
	results = @twitter.search(SEARCH_STRING)
	@tweets = results.take(10)

end

#-------------------------------------------------------------------------------

def fetch_users # Huiqiang
    user_id = params[:screen_name]
    query = %{SELECT pickup_location, date, time 
              From Orders
              WHERE UserID = '%#{user_id}%'}
    @results = @db.execute query, params[:search]

end

#-------------------------------------------------------------------------------