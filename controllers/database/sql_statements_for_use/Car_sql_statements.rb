#CARS
require 'sinatra'
set :bind, '0.0.0.0'
require 'sqlite3'
#these two should be global somewhere
@db = SQLite3::Database
@db = SQLite3::Database.open './database1.sqlite'




def deletecar(carID_to_delete)    #params[:search] into that           #works
    if carID_to_delete.is_a?(Integer)
    @db.execute(
        'DELETE FROM Cars WHERE CarID = ?',
        [carID_to_delete])
    else
      puts "invalid data types"
    end
end

def search_car_type(chosen_car_type)      #car type as integer you are searching for (e.g. sedan = 0, suv = 1...)   #works
  if chosen_car_type.is_a?(Integer)
    query = %{ SELECT CarID, Status, Type, Seats 
        FROM Cars 
        WHERE Type Like '%' || ? || '%'}
        @results = @db.execute query, chosen_car_type
  else
      puts "invalid data types"
  end
end

def search_car_status(chosen_car_status)      #car status as integer you are searching for (e.g. available = 0, unavailable = 1, busy = 2)            #works
  if chosen_car_status.is_a?(Integer)
    query = %{ SELECT CarID, Status, Seats
        FROM Cars 
        WHERE Status Like '%' || ? || '%'}
    @results = @db.execute query, chosen_car_status
  else
      puts "invalid data types"
  end
end



def count_available_cars()     #counts available cars for use on front page of website  #works
    query = 'SELECT COUNT(*) FROM Cars WHERE Status = 0';
    @results = @db.execute query
end

def search_by_carid(car_id)         #Searches for a carid and displays information on that car   #works
  if car_id.is_a?(Integer)
    query = %{ SELECT CarID, Status, Type, Seats
        FROM Cars 
        WHERE CarID Like '%' || ? || '%'}
    @results = @db.execute query, car_id
  else
    puts "invalid data types"
  end
end

def add_cars(type,seats)  #status is 0                #works 
  if type.is_a?(Integer) && seats.is_a?(Integer)
    carID = @db.execute ('SELECT MAX(CarID)+1 FROM Cars');
    query = @db.execute(
      'INSERT INTO Cars VALUES (?, ?, ?, ?)',
      [carID, 0, type, seats])
    return query
  else
      puts "invalid data types"
  end
end










