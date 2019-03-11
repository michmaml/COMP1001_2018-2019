# fetch_orders.rb
# Gets all of the tweets that include 
# COM1001 Spring Semester Assignment 2019
# <name here>

get '/search' do
    unless params[:search].nil?
    user_id = tweet.user.screen_name
        query = %{SELECT Pickup_location, 
              FROM Orders
             WHERE UserID = '%#{user_id}'}
        @results = @db.execute query
    end
end
    
get '/orders' do
    screen_name ="Placeholder"
    #screen_name = get_user's_username/twitter_login
   
    @ordered_trips = []
    ordered_trips.push({
       date: ordered_trips[0].tweet.created_at
       time: tweets.user_timeline()
       from: "Operator"
       to: "Operator"
       
       id: tweets.id
       screen_name: screen_name
       })
  erb :orders
    
end