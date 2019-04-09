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

def delete_user # Jamie
	
	userID = params[:user_id].strip.to_i
    @db.execute(
			"UPDATE User_details SET Status = #{USER_STATUS_INACTIVE} WHERE UserID = ?;",
			[userID])
	
end

#-------------------------------------------------------------------------------

def delete_car #Toby
	
	carID = params[:car_id].strip.to_i
    puts carID
    @db.execute(
			"DELETE FROM cars WHERE CarID = ?;",
			[carID])

end