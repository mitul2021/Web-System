#Gems
require "sinatra"
require "require_all"

include ERB::Util

#App
require_relative "db/db"
require_all "controllers"
require_all "models"

enable :sessions
set :session_secret, "$g]Rd2M/WbJ`~~<GZWdH@rwghb3456213HHdfde2_gckCtLJJkySYG"

set :bind, "0.0.0.0" #for codio

