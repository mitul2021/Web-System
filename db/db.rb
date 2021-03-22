require "logger"
require "sequel"
require "sqlite3"


# ensuring that you are using the users.sqlite3 database for production
name = ENV.fetch("APP_ENV", "users")

# # find the path to the database
db_dir_path = File.dirname(__FILE__)
db_path = "#{db_dir_path}/#{name}.sqlite3"

# # find the path to the log
log_dir_path = "#{db_dir_path}/log/"
log_path = "#{log_dir_path}/#{name}.log"

# # create log directory if it does not exist
Dir.mkdir(log_dir_path) unless File.exist?(log_dir_path)

# # set up the Sequel database instance
DB = Sequel.sqlite(db_path, logger: Logger.new(log_path))
