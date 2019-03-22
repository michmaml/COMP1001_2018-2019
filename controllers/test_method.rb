def create_order(text, time, carID)

    return 0 if   
    text = text.strip
	time = time.strip.to_i    
	carID = carID.strip.to_i   
    ary = [text, time, carID]		
	
end

def create_user(display_name, email, password)
    
    return 1 if  
    display_name = display_name.strip
    email = email.strip
	password = password.strip
    ary = [display_name, email, password]
end