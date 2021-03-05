require "logger"
require "sequel"

DB = Sequel.sqlite("mentor_table.sqlite3", logger: Logger.new("mentor.log"))

dataset = DB[:mentor]
num_rows = dataset.count

dataset.each do |record|
    puts "#{record[:first_name]} #{record[:surname]} #{record[:profile_job_title]}"
end