

post '/Added_car' do
  @submitted = true
  @Status = params[:Status].strip
  @Type = params[:Type].strip
  @Seats = params[:Seats].strip
  CarID = @db.get_first_value 'SELECT MAX(CARID)+1 FROM Cars';
  @db.execute(
      'INSERT INTO Cars VALUES (?, ?, ?, ?)',
      [CarID, @Status, @Type, @Seats])
  erb :Add_cars
end
  