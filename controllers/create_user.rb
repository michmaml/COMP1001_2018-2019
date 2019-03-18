# create_user.rb
# <description here>
# COM1001 Spring Semester Assignment 2019
# <name here>


# Create user based on details from params[].
@submitted = true
VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
#sanitize values
@name = params[:display_name].strip
@email = params[:email].strip
@password = params[:password].strip


#perform validation
@name_ok = !@name.nil? && @name != ""
@email_ok = !@email.nil? && @email != "" && @email =~ VALID_EMAIL_REGEX
@all_ok = @name_ok && @email_ok
if @all_ok 
	id = @db.get_first_value 'SELECT MAX(UserID)+1 FROM Userdetails';
	@db.execute('INSERT INTO Userdetails VALUES (?,?,?,?,?,?,?,?,?,?)', 
		[id, @name, @name, @email, @name, @password,0,0,0,0])

else redirect '/error'
