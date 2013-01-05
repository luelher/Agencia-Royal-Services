require 'active_record'
require 'pg'

ActiveRecord::Base.logger = Logger.new(STDERR)
ActiveRecord::Base.colorize_logging = false
 
ActiveRecord::Base.establish_connection(
  :adapter => "postgresql",
  :host => 'localhost',
  :username => 'SIMA005'
  :password => 'SIMA005'
  :database => 'pdval'
)

