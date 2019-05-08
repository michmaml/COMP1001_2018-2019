#-------------------------------------------------------------------------------
# DELETE functions
#-------------------------------------------------------------------------------

def archive_order # Jamie
	
	orderID = params[:order_id].strip.to_i
    @db.execute(
			"UPDATE Orders SET Status = #{ORDER_STATUS_ARCHIVED} WHERE OrderID = ?;",
			[orderID])

end

#-------------------------------------------------------------------------------

def delete_order # Kacper
	
	orderID = params[:order_id].strip.to_i
    @db.execute(
			"UPDATE Orders SET Status = #{ORDER_STATUS_CANCELLED} WHERE OrderID = ?;",
			[orderID])

end

#-------------------------------------------------------------------------------

def reject_tweet # Jamie
	
	tweetID = params[:order_id].strip.to_i
	@db.execute(
		"UPDATE Tweets SET Status = #{TWEET_STATUS_REJECTED} WHERE TweetID = ?;",
		[tweetID])
	
end

#-------------------------------------------------------------------------------

def delete_user # Jamie
	
	userID = params[:user_id].strip.to_i
    @db.execute(
			"UPDATE User_details SET Status = #{USER_STATUS_INACTIVE} WHERE UserID = ?;",
			[userID])
	
end

#-------------------------------------------------------------------------------