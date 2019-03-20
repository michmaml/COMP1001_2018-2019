require 'digest'
sha256 = Digest::SHA256.new

@name = "ujijmu8j"
# Other encoding formats
@coded_password = Digest::SHA256.hexdigest @name
puts @coded_password