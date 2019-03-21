#Users
require 'sinatra'
set :bind, '0.0.0.0'
require 'sqlite3'
@db = SQLite3::Database.new('../../../models/Twaxis.sqlite')
@db.results_as_hash = true




def deactivate_user(userID, userID_to_de_activate)          #works
    if userID_to_de_activate.is_a?(Integer) && userID.is_a?(Integer)
    @userID_to_de_activate = userID_to_de_activate
    @userID = userID
    query = %{ UPDATE User_details
         SET Account_deactivated = @userID_to_de_activate
        WHERE UserID = @userID}
    @results = @db.execute query, @userID_to_de_activate, @userID
    else
      puts "invalid data types"
    end
end

def add_reward_point(userID)          #works
    if userID.is_a?(Integer)
    @userID = userID
    query = %{ UPDATE User_details
        SET Reward_points = Reward_points + 1
        WHERE UserID = @userID}
    @results = @db.execute query, @userID
    else
      puts "invalid data types"
    end
end

def add_to_total_orders(userID)          #works
    if userID.is_a?(Integer)
    @userID = userID
    query = %{ UPDATE User_details
        SET Total_orders = Total_orders + 1
        WHERE UserID = @userID}
    @results = @db.execute query, @userID
    else
      puts "invalid data types"
    end
end

def add_to_total_cancellations(userID)          #works
    if userID.is_a?(Integer)
    @userID = userID
    query = %{ UPDATE User_details
        SET Total_cancellations = Total_cancellations + 1
        WHERE UserID = @userID}
    @results = @db.execute query, @userID
    else
      puts "invalid data types"
    end
end


def search_by_surname(surname)         #Searches for a user surname and displays information on that user   #works
  if surname.is_a?(String)
    @surname = surname.strip
    query = %{ SELECT UserID, Firstname, Surname, Twitter_handle, Email, Reward_points, Account_deactivated, Total_orders, Total_cancellations
        FROM User_details
        WHERE Surname Like '%' || ? || '%'}
    @results = @db.execute query, @surname
  else
    puts "invalid data types"
  end
end

def search_by_twitter_handle(twitter_handle)         #Searches for a user Twitter_handle and displays information on that user   #works`
    if twitter_handle.is_a?(String)
    @twitter_handle = twitter_handle.strip
    query = %{ SELECT UserID, Firstname, Surname, Twitter_handle, Email, Reward_points, Account_deactivated, Total_orders, Total_cancellations
        FROM User_details
        WHERE Twitter_handle Like '%' || ? || '%'}
    @results = @db.execute query, @twitter_handle
    else
      puts "invalid data types"
    end
end

def search_by_firstname(firstname)         #Searches for a user Firstname and displays information on that user   #works
  if firstname.is_a?(String)
    @Firstname = firstname.strip
    query = %{ SELECT UserID, Firstname, Surname, Twitter_handle, Email, Reward_points, Account_deactivated, Total_orders, Total_cancellations
        FROM User_details
        WHERE Firstname Like '%' || ? || '%'}
    @results = @db.execute query, @Firstname
  else
    puts "invalid data types"
  end
end



def search_by_userid(user_id)         #Searches for a user id and displays information on that user   #works
  if user_id.is_a?(Integer)
    query = %{ SELECT UserID, Firstname, Surname, Twitter_handle, Email, Reward_points, Account_deactivated, Total_orders, Total_cancellations
        FROM User_details 
        WHERE UserID Like '%' || ? || '%'}
    @results = @db.execute query, user_id
  else
    puts "invalid data types"
  end
end

def add_user(firstname, surname, twitter_handle, password, email)  #Adds a new user to system total orders, total cancellations, account deactivated, access level and reward points is automatically set to 0                #works 
  if firstname.is_a?(String) && surname.is_a?(String) && twitter_handle.is_a?(String) && password.is_a?(String) && email.is_a?(String)
    userID = @db.get_first_value ('SELECT MAX(UserID)+1 FROM User_details');
    query = @db.execute(
      'INSERT INTO User_details VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
      [userID, firstname, surname, twitter_handle, password, email, 0, 0, 0, 0, 0])
    return query
  else
      puts "invalid data types"
  end
end












