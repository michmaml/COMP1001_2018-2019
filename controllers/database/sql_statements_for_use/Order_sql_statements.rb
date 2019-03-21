#ORDERS
require 'sinatra'
set :bind, '0.0.0.0'
require 'sqlite3'
@db = SQLite3::Database.new('../../../models/Twaxis.sqlite')
@db.results_as_hash = true


def create_order(userID,carID,pickup_location,date,time)                #creates an order, status is set to 0, which means it is ongoing  #works
  if userID.is_a?(Integer) && carID.is_a?(Integer) && pickup_location.is_a?(String) && date.is_a?(String) && time.is_a?(String)
    @Pickup_location = pickup_location.strip
    @Date = date.strip
    @Time = time.strip
    orderID = @db.execute ('SELECT MAX(OrderID)+1 FROM Orders');
    query = @db.execute(
      'INSERT INTO Orders VALUES (?, ?, ?, ?, ?, ?, ?)',
      [orderID, userID, carID, @Pickup_location, @Date, @Time, 0])
    return query
  else
      puts "invalid data types"
  end
end

def search_order_by_carid(carID)               #gets all information on all orders by a certain car           #works
  if carID.is_a?(Integer)
    query = %{ SELECT OrderID, CarID, UserID, Pickup_location, Date, time, Status
        FROM Orders 
        WHERE CarID Like '%' || ? || '%'}
    @results = @db.execute query, carID
  else
      puts "invalid data types"
  end
end

def search_order_by_userid(userID)             #gets all information on all orders by a certain user                 #works
  if userID.is_a?(Integer)
      query = %{ SELECT OrderID, CarID, UserID, Pickup_location, Date, time, Status
          FROM Orders 
          WHERE UserID Like '%' || ? || '%'}
  @results = @db.execute query, userID
  else
      puts "invalid data types"
  end
end

def search_order_by_ongoing()               #gets all information on all orders by a certain car           #works
    query = %{ SELECT OrderID, CarID, UserID, Pickup_location, Date, time, Status
        FROM Orders 
        WHERE Status = 0}
    @results = @db.execute query
end

def change_order_status(order_id,new_status)         #Changes an orders status (0 ==> 1 or 2)    #works
  if order_id.is_a?(Integer) && new_status.is_a?(Integer)
    @order_id = order_id
    @new_status = new_status
    query = %{ UPDATE Orders
        SET Status = @New_status
        WHERE OrdersID = @order_id}
    @results = @db.execute query, @order_id, @new_status
  else
    puts "invalid data types"
  end
end