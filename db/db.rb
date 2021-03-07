require "logger"
require "sequel"
require "sqlite3"

type = "mentor_table" #hardcoded for testing purposes, it will depend on the type of user.

# db_dir_path = File.dirname(__FILE__)
# db_path = "#{db_dir_path}/#{name}.sqlite3"

# log_dir_path = "#{db_dir_path}/log/"
# log_path = "#{log_dir_path}/#{name}.log"

# Dir.mkdir(log_dir_path) unless File.exist?(log_dir_path)

# DB = Sequel.sqlite(db_path, logger: Logger.new(log_path))


db_path = File.dirname(__FILE__)
db = "#{db_path}/#{type}.sqlite3"

# find the path to the log
log_path = "#{File.dirname(__FILE__)}/../log/"
log = "#{log_path}/#{type}.log"

# create log directory if it does not exist
Dir.mkdir(log_path) unless File.exist?(log_path)

# set up the Sequel database instance
DB = Sequel.sqlite(db, logger: Logger.new(log))