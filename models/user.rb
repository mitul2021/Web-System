
DB = Sequel.sqlite("users.sqlite3", logged: Logger.new('user.log'))


class User < Sequel::Model
end

