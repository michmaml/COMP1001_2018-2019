#-------------------------------------------------------------------------------
# UPDATE functions
#-------------------------------------------------------------------------------

def update_order
   orderID = params[:in_reply_to_status_id].strip.to_i
    @db.execute(
			"UPDATE SET Status = 1 WHERE CustomerID = ?;",
			[orderID])

	
end

#-------------------------------------------------------------------------------

def update_user
	
end

#-------------------------------------------------------------------------------